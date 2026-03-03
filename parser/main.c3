module parser;

import std::io;
import std::io::file;
import std::collections::list;
import std::collections::map;
import std::encoding::json;
import std::collections::object;

alias TypeMap = HashMap {String, String};

// ----------------------------------------------------------------
// Name transformation helpers
// ----------------------------------------------------------------

// "adapter_type" -> "AdapterType", "discrete_GPU" -> "DiscreteGPU"
fn String snake_to_pascal(String s, Allocator alloc)
{
	DString result;
	result.init(alloc, s.len + 4);
	bool cap_next = true;
	foreach (c : s)
	{
		if (c == '_')
		{
			cap_next = true;
			continue;
		}
		result.append_char(cap_next ? c.to_upper() : c);
		cap_next = false;
	}
	return result.copy_str(alloc);
}

// "create_buffer" -> "createBuffer"
fn String snake_to_camel(String s, Allocator alloc)
{
	DString result;
	result.init(alloc, s.len + 4);
	bool first = true;
	bool cap_next = false;
	foreach (c : s)
	{
		if (c == '_')
		{
			cap_next = true;
			continue;
		}
		if (first)
		{
			result.append_char(c.to_lower());
			first = false;
		}
		else
		{
			result.append_char(cap_next ? c.to_upper() : c);
		}
		cap_next = false;
	}
	return result.copy_str(alloc);
}

// "discrete_GPU" -> "DISCRETE_GPU", "map_read" -> "MAP_READ"
// Inserts underscore before uppercase letters that follow lowercase letters
fn String to_screaming_snake(String s, Allocator alloc)
{
	DString result;
	result.init(alloc, s.len + 8);
	bool prev_lower = false;
	foreach (c : s)
	{
		if (c == '_')
		{
			result.append_char('_');
			prev_lower = false;
			continue;
		}
		if (c.is_upper() && prev_lower)
		{
			result.append_char('_');
		}
		result.append_char(c.to_upper());
		prev_lower = c.is_lower();
	}
	return result.copy_str(alloc);
}

// "uint32_max" -> "(~0u)", "uint64_max" -> "(~0ul)", etc.
fn String resolve_constant_value(String value)
{
	switch (value)
	{
		case "uint32_max":
			return "(~0u)";
		case "uint64_max":
			return "(~0ul)";
		case "usize_max":
			return "(usz)(~0ul)";
		case "nan":
			return "float.nan";
		default:
			return value;
	}
}

// Rename struct/arg field names that collide with C3 reserved keywords
fn String safe_field_name(String name)
{
	switch (name)
	{
		case "module":
			return "shader_module";
		default:
			return name;
	}
}

// Resolves an inner type string (without array<> wrapper) to a C3 type string
fn String resolve_inner_type(String inner, TypeMap* type_map, Allocator alloc)
{
	String? mapped = type_map.get(inner);
	if (try mapped) return mapped;

	if (inner.starts_with("enum.")) return snake_to_pascal(inner[5..], alloc);
	if (inner.starts_with("struct.")) return snake_to_pascal(inner[7..], alloc);
	if (inner.starts_with("object.")) return snake_to_pascal(inner[7..], alloc);
	if (inner.starts_with(
		"bitflag."
	)) return snake_to_pascal(inner[8..], alloc);
	if (inner.starts_with("callback."))
	{
		String cb_pascal = snake_to_pascal(inner[9..], alloc);
		return dstring::join(
			alloc,
			{ "WGPU", cb_pascal, "Callback" },
			""
		).copy_str(alloc);
	}
	return inner;
}

// Resolves a WgpuArg's type to a C3 type string (including pointer suffix)
fn String resolve_type(WgpuArg arg, TypeMap* type_map, Allocator alloc)
{
	String base = resolve_inner_type(arg.inner_type, type_map, alloc);
	if (arg.pointer != "" || arg.is_array)
	{
		return dstring::join(alloc, { base, "*" }, "").copy_str(alloc);
	}
	return base;
}

// ----------------------------------------------------------------
// Argument / method parsing helpers
// ----------------------------------------------------------------

fn WgpuArg parse_arg(Object* obj)
{
	WgpuArg arg;
	arg.name = obj.get_string("name") ?? "";
	arg.type_ref = obj.get_string("type") ?? "";
	arg.pointer = obj.get_string("pointer") ?? "";
	arg.optional = obj.get_bool("optional") ?? false;

	if (arg.type_ref.starts_with("array<") && arg.type_ref.ends_with(">"))
	{
		arg.is_array = true;
		arg.inner_type = arg.type_ref[6..arg.type_ref.len - 2];
	}
	else
	{
		arg.is_array = false;
		arg.inner_type = arg.type_ref;
	}
	return arg;
}

fn WgpuMethod parse_method(Object* obj)
{
	WgpuMethod meth;
	meth.name = obj.get_string("name") ?? "";
	meth.callback = obj.get_string("callback") ?? "";

	if (obj.has_key("returns"))
	{
		Object* ret = obj.get("returns")!!;
		meth.returns_type = ret.get_string("type") ?? "";
		meth.returns_ptr = ret.get_string("pointer") ?? "";
	}

	if (obj.has_key("args"))
	{
		Object* args_arr = obj.get("args")!!;
		for (usz k = 0; k < args_arr.get_len(); k++)
		{
			Object* a = args_arr.get_at(k);
			if (!a.is_null()) meth.args.push(parse_arg(a));
		}
	}
	return meth;
}

// ----------------------------------------------------------------
// Parse functions for each JSON category
// ----------------------------------------------------------------

fn void parse_constants(Object* root, ConstantList* out)
{
	if (!root.has_key("constants")) return;
	Object* arr = root.get("constants")!!;
	for (usz i = 0; i < arr.get_len(); i++)
	{
		Object* item = arr.get_at(i);
		if (item.is_null()) continue;
		WgpuConstant c = {
			.name = item.get_string("name") ?? "",
			.value = item.get_string("value") ?? "",
		};
		if (c.name != "") out.push(c);
	}
}

fn void parse_enums(Object* root, EnumList* out)
{
	if (!root.has_key("enums")) return;
	Object* arr = root.get("enums")!!;
	for (usz i = 0; i < arr.get_len(); i++)
	{
		Object* item = arr.get_at(i);
		if (item.is_null()) continue;
		WgpuEnum e;
		e.name = item.get_string("name") ?? "";
		if (e.name == "") continue;

		if (item.has_key("entries"))
		{
			Object* entries = item.get("entries")!!;
			for (usz j = 0; j < entries.get_len(); j++)
			{
				Object* entry = entries.get_at(j);
				WgpuEntry ve;
				if (entry.is_null())
				{
					ve.is_null = true;
				}
				else
				{
					ve.name = entry.get_string("name") ?? "";
				}
				e.entries.push(ve);
			}
		}
		out.push(e);
	}
}

fn void parse_bitflags(Object* root, BitflagList* out)
{
	if (!root.has_key("bitflags")) return;
	Object* arr = root.get("bitflags")!!;
	for (usz i = 0; i < arr.get_len(); i++)
	{
		Object* item = arr.get_at(i);
		if (item.is_null()) continue;
		WgpuBitflag b;
		b.name = item.get_string("name") ?? "";
		if (b.name == "") continue;

		if (item.has_key("entries"))
		{
			Object* entries = item.get("entries")!!;
			for (usz j = 0; j < entries.get_len(); j++)
			{
				Object* entry = entries.get_at(j);
				if (entry.is_null()) continue;
				WgpuEntry ve;
				ve.name = entry.get_string("name") ?? "";

				if (entry.has_key("value_combination"))
				{
					Object* combo = entry.get("value_combination")!!;
					for (usz k = 0; k < combo.get_len(); k++)
					{
						Object* cv = combo.get_at(k);
						if (!cv.is_null() && cv.is_string())
						{
							ve.value_combination.push(cv.s);
						}
					}
				}
				b.entries.push(ve);
			}
		}
		out.push(b);
	}
}

fn void parse_structs(Object* root, StructList* out)
{
	if (!root.has_key("structs")) return;
	Object* arr = root.get("structs")!!;
	for (usz i = 0; i < arr.get_len(); i++)
	{
		Object* item = arr.get_at(i);
		if (item.is_null()) continue;
		WgpuStruct s;
		s.name = item.get_string("name") ?? "";
		s.kind = item.get_string("type") ?? "standalone";
		if (s.name == "") continue;

		if (item.has_key("members"))
		{
			Object* members = item.get("members")!!;
			for (usz j = 0; j < members.get_len(); j++)
			{
				Object* m = members.get_at(j);
				if (!m.is_null()) s.members.push(parse_arg(m));
			}
		}
		out.push(s);
	}
}

fn void parse_objects(Object* root, ObjectList* out)
{
	if (!root.has_key("objects")) return;
	Object* arr = root.get("objects")!!;
	for (usz i = 0; i < arr.get_len(); i++)
	{
		Object* item = arr.get_at(i);
		if (item.is_null()) continue;
		WgpuObject obj;
		obj.name = item.get_string("name") ?? "";
		if (obj.name == "") continue;

		if (item.has_key("methods"))
		{
			Object* methods = item.get("methods")!!;
			for (usz j = 0; j < methods.get_len(); j++)
			{
				Object* m = methods.get_at(j);
				if (!m.is_null()) obj.methods.push(parse_method(m));
			}
		}
		out.push(obj);
	}
}

fn void parse_functions(Object* root, FunctionList* out)
{
	if (!root.has_key("functions")) return;
	Object* arr = root.get("functions")!!;
	for (usz i = 0; i < arr.get_len(); i++)
	{
		Object* item = arr.get_at(i);
		if (item.is_null()) continue;
		WgpuMethod meth = parse_method(item);
		WgpuFunction func = {
			.name = meth.name,
			.returns_type = meth.returns_type,
			.returns_ptr = meth.returns_ptr,
			.callback = meth.callback,
			.args = meth.args,
		};
		if (func.name != "") out.push(func);
	}
}

fn void parse_callbacks(Object* root, CallbackList* out)
{
	if (!root.has_key("callbacks")) return;
	Object* arr = root.get("callbacks")!!;
	for (usz i = 0; i < arr.get_len(); i++)
	{
		Object* item = arr.get_at(i);
		if (item.is_null()) continue;
		WgpuCallback cb;
		cb.name = item.get_string("name") ?? "";
		cb.style = item.get_string("style") ?? "";
		if (cb.name == "") continue;

		if (item.has_key("args"))
		{
			Object* args_arr = item.get("args")!!;
			for (usz j = 0; j < args_arr.get_len(); j++)
			{
				Object* a = args_arr.get_at(j);
				if (!a.is_null()) cb.args.push(parse_arg(a));
			}
		}
		out.push(cb);
	}
}

// ----------------------------------------------------------------
// Code generation: lib/webgpu.c3
// ----------------------------------------------------------------

fn void generate_types(
	File* f,
	Allocator alloc,
	TypeMap* type_map,
	ConstantList* constants,
	EnumList* enums,
	BitflagList* bitflags,
	StructList* structs,
	CallbackList* callbacks,
	ObjectList* objects
)
{
	f.write("module wgpu;\n\n")!!;

	// 0. StringView — matches WGPUStringView { char* data; size_t length }
	// sv(s) wraps a null-terminated string; (usz)(~0ul) == WGPU_STRLEN signals null-terminated.
	f.write("struct StringView {\n    char* data;\n    usz   length;\n}\n")!!;
	f.write(
		"fn StringView sv(char* s) { return { .data = s, .length = (usz)(~0ul) }; }\n"
	)!!;
	f.write(
		"fn StringView sv_empty()  { return { .data = null, .length = 0 }; }\n\n"
	)!!;

	// 1. Object handles
	f.write("// Object handles\n")!!;
	foreach (obj : *objects)
	{
		String pascal = snake_to_pascal(obj.name, alloc);
		f.write(
			dstring::join(
				alloc,
				{ "typedef ", pascal, " = inline void*;\n" },
				""
			).str_view()
		)!!;
	}
	f.write("\n")!!;

	// 2. Constants (JSON names are snake_case, convert to WGPU_SCREAMING_SNAKE)
	f.write("// Constants\n")!!;
	foreach (c : *constants)
	{
		String upper = to_screaming_snake(c.name, alloc);
		String val = resolve_constant_value(c.value);
		f.write(
			dstring::join(
				alloc,
				{ "const WGPU_", upper, " = ", val, ";\n" },
				""
			).str_view()
		)!!;
	}
	f.write("\n")!!;

	// 3. Callback typedefs + CallbackInfo structs
	// Each callback_mode callback gets:
	// a) A function pointer typedef: def WGPUBufferMapCallback = fn void(...)
	// b) A CallbackInfo struct: struct BufferMapCallbackInfo { ChainMeta* next_in_chain; CallbackMode mode; WGPUBufferMapCallback callback; void* userdata1; void* userdata2; }
	f.write("// Callbacks\n")!!;
	foreach (cb : *callbacks)
	{
		String pascal = snake_to_pascal(cb.name, alloc);
		DString line = dstring::join(
			alloc,
			{ "alias WGPU", pascal, "Callback = fn void(" },
			""
		);
		foreach (usz i, arg : cb.args)
		{
			String arg_type = resolve_type(arg, type_map, alloc);
			if (i > 0) line.append_string(", ");
			line.append_string(
				dstring::join(alloc, { arg_type, " ", arg.name }, "").str_view()
			);
		}
		// callback_mode callbacks have implicit userdata1/userdata2 params in the C ABI
		if (cb.style == "callback_mode")
		{
			if (cb.args.len() > 0) line.append_string(", ");
			line.append_string("void* userdata1, void* userdata2");
		}
		line.append_string(");\n");
		f.write(line.str_view())!!;

		// Generate CallbackInfo struct for callback_mode callbacks
		if (cb.style == "callback_mode")
		{
			String info_name = dstring::join(
				alloc,
				{ pascal, "CallbackInfo" },
				""
			).copy_str(alloc);
			f.write(
				dstring::join(
					alloc,
					{
						"struct ",
						info_name,
						" {\n",
						"    void* next_in_chain;\n",
						"    CallbackMode mode;\n",
						"    WGPU",
						pascal,
						"Callback callback;\n",
						"    void* userdata1;\n",
						"    void* userdata2;\n",
						"}\n"
					},
					""
				).str_view()
			)!!;
		}
	}
	f.write("\n")!!;

	// 4. Enums
	// Entry position in the JSON array is the enum value (0-indexed).
	// Null entries are gaps - skip them but count their index.
	// Constant names: TYPE_SCREAMING + "_" + ENTRY_SCREAMING
	f.write("// Enums\n")!!;
	foreach (e : *enums)
	{
		String pascal = snake_to_pascal(e.name, alloc);
		String type_upper = to_screaming_snake(e.name, alloc);
		DString block = dstring::join(
			alloc,
			{ "typedef ", pascal, " = inline uint;\n" },
			""
		);
		foreach (usz i, entry : e.entries)
		{
			if (entry.is_null || entry.name == "") continue;
			String entry_upper = to_screaming_snake(entry.name, alloc);
			String const_name = dstring::join(
				alloc,
				{ type_upper, "_", entry_upper },
				""
			).copy_str(alloc);
			char[16] num_buf;
			String num_str = (String)io::bprintf(&num_buf, "%d", i)!!;
			block.append_string(
				dstring::join(
					alloc,
					{
						"const ",
						pascal,
						" ",
						const_name,
						" = ",
						num_str,
						";\n"
					},
					""
				).str_view()
			);
		}
		block.append_string("\n");
		f.write(block.str_view())!!;
	}

	// 5. Bitflags
	// Entries: "none" -> 0, regular entries get sequential bit positions (0, 1, 2...),
	// entries with value_combination are OR of other named constants.
	f.write("// Bitflags\n")!!;
	foreach (b : *bitflags)
	{
		String pascal = snake_to_pascal(b.name, alloc);
		String type_upper = to_screaming_snake(b.name, alloc);
		DString block = dstring::join(
			alloc,
			{ "typedef ", pascal, " = inline ulong;\n" },
			""
		);
		int bit_idx = -1;
		foreach (entry : b.entries)
		{
			if (entry.is_null || entry.name == "") continue;
			String entry_upper = to_screaming_snake(entry.name, alloc);
			String const_name = dstring::join(
				alloc,
				{ type_upper, "_", entry_upper },
				""
			).copy_str(alloc);
			String val_str;

			if (entry.value_combination.len() > 0)
			{
				// Composite value: OR of referenced constants
				DString combo;
				combo.init(alloc, 64);
				foreach (usz ci, cv : entry.value_combination)
				{
					String cv_upper = to_screaming_snake(cv, alloc);
					String cv_const = dstring::join(
						alloc,
						{ type_upper, "_", cv_upper },
						""
					).copy_str(alloc);
					if (ci > 0) combo.append_string(" | ");
					combo.append_string(cv_const);
				}
				val_str = combo.copy_str(alloc);
			}
			else if (entry_upper == "NONE")
			{
				val_str = "0";
			}
			else
			{
				bit_idx++;
				char[32] hex_buf;
				val_str = (String)io::bprintf(
					&hex_buf,
					"0x%08x",
					(uint)(1u << (uint)bit_idx)
				)!!;
			}
			block.append_string(
				dstring::join(
					alloc,
					{
						"const ",
						pascal,
						" ",
						const_name,
						" = ",
						val_str,
						";\n"
					},
					""
				).str_view()
			);
		}
		block.append_string("\n");
		f.write(block.str_view())!!;
	}

	// 6. Structs
	// Array members expand to (count, pointer) pairs matching the C ABI.
	f.write("// Structs\n")!!;
	foreach (s : *structs)
	{
		String pascal = snake_to_pascal(s.name, alloc);
		DString block = dstring::join(alloc, { "struct ", pascal, " {\n" }, "");
		// Emit chain header first for extensible / extension structs
		if (s.kind == "extensible" || s.kind == "extensible_callback_arg")
		{
			block.append_string("    void* next_in_chain;\n");
		}
		else if (s.kind == "extension")
		{
			block.append_string("    void* chain_next;\n");
			block.append_string("    uint  s_type;\n");
		}

		foreach (m : s.members)
		{
			String field_name = safe_field_name(m.name);
			if (m.is_array)
			{
				String elem_type = resolve_inner_type(
					m.inner_type,
					type_map,
					alloc
				);
				block.append_string(
					dstring::join(
						alloc,
						{
							"    usz ",
							field_name,
							"_count;\n",
							"    ",
							elem_type,
							"* ",
							field_name,
							";\n"
						},
						""
					).str_view()
				);
			}
			else
			{
				String c3_type = resolve_type(m, type_map, alloc);
				block.append_string(
					dstring::join(
						alloc,
						{ "    ", c3_type, " ", field_name, ";\n" },
						""
					).str_view()
				);
			}
		}
		// C3 does not allow zero-sized structs; add a padding byte for empty structs
		if (s.members.len() == 0)
		{
			block.append_string("    char _pad;\n");
		}
		block.append_string("}\n\n");
		f.write(block.str_view())!!;
	}
}

// ----------------------------------------------------------------
// Code generation: lib/commands.c3
// ----------------------------------------------------------------

fn String build_return_type(
	String returns_type,
	String returns_ptr,
	TypeMap* type_map,
	Allocator alloc
)
{
	if (returns_type == "") return "void";
	WgpuArg ret_arg = {
		.type_ref = returns_type,
		.pointer = returns_ptr,
		.inner_type = returns_type,
	};
	if (returns_type.starts_with("array<") && returns_type.ends_with(">"))
	{
		ret_arg.is_array = true;
		ret_arg.inner_type = returns_type[6..returns_type.len - 2];
	}
	return resolve_type(ret_arg, type_map, alloc);
}

fn void write_args(
	File* f,
	ArgList* args,
	TypeMap* type_map,
	Allocator alloc,
	bool first_arg
)
{
	foreach (usz i, arg : *args)
	{
		if (!first_arg || i > 0) f.write(", ")!!;
		if (arg.is_array)
		{
			String elem_type = resolve_inner_type(
				arg.inner_type,
				type_map,
				alloc
			);
			f.write(
				dstring::join(
					alloc,
					{
						"usz ",
						arg.name,
						"_count, ",
						elem_type,
						"* ",
						arg.name
					},
					""
				).str_view()
			)!!;
		}
		else
		{
			String arg_type = resolve_type(arg, type_map, alloc);
			f.write(
				dstring::join(alloc, { arg_type, " ", arg.name }, "").str_view()
			)!!;
		}
	}
}

// Writes the callback info arg for async methods: ", BufferMapCallbackInfo callback_info"
fn void write_callback_arg(File* f, String callback_ref, Allocator alloc)
{
	if (callback_ref == "") return;
	// callback_ref is like "callback.buffer_map" -> strip "callback." -> "buffer_map"
	String cb_name = callback_ref.starts_with(
		"callback."
	) ? callback_ref[9..] : callback_ref;
	String pascal = snake_to_pascal(cb_name, alloc);
	f.write(
		dstring::join(
			alloc,
			{ ", ", pascal, "CallbackInfo callback_info" },
			""
		).str_view()
	)!!;
}

fn void generate_commands(
	File* f,
	Allocator alloc,
	TypeMap* type_map,
	FunctionList* functions,
	ObjectList* objects
)
{
	f.write("module wgpu;\n\n")!!;

	// Top-level functions: create_instance -> extern fn Instance createInstance(...) @cname("wgpuCreateInstance")
	f.write("// Top-level functions\n")!!;
	foreach (func : *functions)
	{
		String c3_name = snake_to_camel(func.name, alloc);
		String c_pascal = snake_to_pascal(func.name, alloc);
		// Async functions with callbacks return Future
		String ret_type = func.callback
			!= "" ? "Future" : build_return_type(
				func.returns_type,
				func.returns_ptr,
				type_map,
				alloc
			);

		f.write(
			dstring::join(
				alloc,
				{ "extern fn ", ret_type, " ", c3_name, "(" },
				""
			).str_view()
		)!!;
		write_args(f, &func.args, type_map, alloc, true);
		write_callback_arg(f, func.callback, alloc);
		f.write(
			dstring::join(
				alloc,
				{ ") @cname(\"wgpu", c_pascal, "\");\n" },
				""
			).str_view()
		)!!;
	}
	f.write("\n")!!;

	// Object methods: device.create_buffer -> extern fn Buffer deviceCreateBuffer(Device self, ...) @cname("wgpuDeviceCreateBuffer")
	foreach (obj : *objects)
	{
		String obj_pascal = snake_to_pascal(obj.name, alloc);
		f.write(
			dstring::join(
				alloc,
				{ "// ", obj_pascal, " methods\n" },
				""
			).str_view()
		)!!;

		foreach (meth : obj.methods)
		{
			String meth_pascal = snake_to_pascal(meth.name, alloc);
			String c3_fn_prefix = snake_to_camel(obj.name, alloc);
			String c3_fn_name = dstring::join(
				alloc,
				{ c3_fn_prefix, meth_pascal },
				""
			).copy_str(alloc);
			String c_fn_name = dstring::join(
				alloc,
				{ "wgpu", obj_pascal, meth_pascal },
				""
			).copy_str(alloc);
			// Async methods with callbacks return Future
			String ret_type = meth.callback
				!= "" ? "Future" : build_return_type(
					meth.returns_type,
					meth.returns_ptr,
					type_map,
					alloc
				);

			f.write(
				dstring::join(
					alloc,
					{
						"extern fn ",
						ret_type,
						" ",
						c3_fn_name,
						"(",
						obj_pascal,
						" self"
					},
					""
				).str_view()
			)!!;
			write_args(f, &meth.args, type_map, alloc, false);
			write_callback_arg(f, meth.callback, alloc);
			f.write(
				dstring::join(
					alloc,
					{ ") @cname(\"", c_fn_name, "\");\n" },
					""
				).str_view()
			)!!;
		}
		f.write("\n")!!;
	}
}

// ----------------------------------------------------------------
// main
// ----------------------------------------------------------------

fn void main(String[] args)
{
	DynamicArenaAllocator allocator;
	allocator.init(allocator: mem, page_size: 512);
	defer allocator.free();

	// Primitive type map: JSON type strings -> C3 types
	TypeMap type_map;
	type_map.init(&allocator);
	type_map.set("uint32", "uint");
	type_map.set("uint64", "ulong");
	type_map.set("uint16", "ushort");
	type_map.set("int32", "int");
	type_map.set("int64", "long");
	type_map.set("float", "float");
	type_map.set("double", "double");
	type_map.set("bool", "uint"); // WGPUBool = uint32_t in C ABI
	type_map.set("usize", "usz");
	type_map.set("c_void", "void");
	type_map.set("float32", "float");
	type_map.set("float64_supertype", "double");
	type_map.set("nullable_float32", "float");
	type_map.set("nullable_string", "StringView");
	type_map.set("out_string", "StringView");
	type_map.set("string_with_default_empty", "StringView");

	// Read the WebGPU JSON spec into a string
	DString json_content;
	json_content.init(&allocator, 256 * 1024);
	{
		File spec = io::file::open("assets/webgpu.json", "rb")!!;
		char[8192] chunk;
		while (true)
		{
			usz? n_res = spec.read(chunk[0..]);
			if (catch n_res) break;
			usz n = n_res;
			if (n == 0) break;
			json_content.append_bytes(chunk[0..n - 1]);
		}
		spec.close()!!;
	}

	// Parse JSON
	Object* root = json::parse_string(&allocator, json_content.str_view())!!;

	// Open output files
	File main_file = io::file::open("lib/webgpu.c3", "wb")!!;
	File cmd_file = io::file::open("lib/commands.c3", "wb")!!;

	// Parse all JSON categories
	ConstantList constants;
	EnumList enums;
	BitflagList bitflags;
	StructList structs;
	ObjectList objects;
	FunctionList functions;
	CallbackList callbacks;

	parse_constants(root, &constants);
	parse_enums(root, &enums);
	parse_bitflags(root, &bitflags);
	parse_structs(root, &structs);
	parse_objects(root, &objects);
	parse_functions(root, &functions);
	parse_callbacks(root, &callbacks);

	io::printfn(
		"Parsed: %d constants, %d enums, %d bitflags, %d structs, %d objects, %d functions, %d callbacks",
		constants.len(),
		enums.len(),
		bitflags.len(),
		structs.len(),
		objects.len(),
		functions.len(),
		callbacks.len()
	);

	// Generate output files
	generate_types(
		&main_file,
		&allocator,
		&type_map,
		&constants,
		&enums,
		&bitflags,
		&structs,
		&callbacks,
		&objects
	);

	generate_commands(&cmd_file, &allocator, &type_map, &functions, &objects);

	main_file.close()!!;
	cmd_file.close()!!;

	io::printfn("Generated lib/webgpu.c3 and lib/commands.c3");
}
