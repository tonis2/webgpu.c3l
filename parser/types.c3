module parser;

import std::collections::list;

alias StringList   = List{String};
alias ArgList      = List{WgpuArg};
alias EntryList    = List{WgpuEntry};
alias MethodList   = List{WgpuMethod};

// Represents a field in a struct or an argument to a function/method.
// type_ref: raw string from JSON (e.g. "enum.address_mode", "struct.buffer_descriptor",
//           "object.device", "bitflag.buffer_usage", "c_void", "uint32", "bool",
//           "string_with_default_empty", "out_string", "array<...>")
// pointer:  "" | "mutable" | "immutable"
// is_array: true when type_ref starts with "array<"
// inner_type: type inside array<...>, or same as type_ref for non-arrays
struct WgpuArg {
    String name;
    String type_ref;
    String pointer;
    bool   optional;
    bool   is_array;
    String inner_type;
}

// A single value inside an enum or bitflag entries array.
// is_null: true when the JSON entry is literal null (gap in enum values)
// value_combination: non-empty for composite bitflag entries (e.g. "all")
struct WgpuEntry {
    String     name;
    StringList value_combination;
    bool       is_null;
}

// An enum type (e.g. adapter_type -> WGPUAdapterType)
struct WgpuEnum {
    String    name;
    EntryList entries;
}

// A bitflag type (e.g. buffer_usage -> WGPUBufferUsage)
struct WgpuBitflag {
    String    name;
    EntryList entries;
}

// A struct type (e.g. buffer_descriptor -> WGPUBufferDescriptor)
struct WgpuStruct {
    String  name;
    ArgList members;
}

// A method on an object or a top-level function
struct WgpuMethod {
    String  name;
    String  returns_type;  // type_ref of return value, "" if void
    String  returns_ptr;   // pointer qualifier on return ("immutable", "mutable", or "")
    String  callback;      // "callback.buffer_map" etc., "" if no callback
    ArgList args;
}

// An object (e.g. device -> WGPUDevice)
struct WgpuObject {
    String     name;
    MethodList methods;
}

// A top-level API function
struct WgpuFunction {
    String  name;
    String  returns_type;
    String  returns_ptr;
    String  callback;
    ArgList args;
}

// A callback type
struct WgpuCallback {
    String  name;
    String  style;
    ArgList args;
}

// A named constant
struct WgpuConstant {
    String name;
    String value;
}

alias EnumList     = List{WgpuEnum};
alias BitflagList  = List{WgpuBitflag};
alias StructList   = List{WgpuStruct};
alias ObjectList   = List{WgpuObject};
alias FunctionList = List{WgpuFunction};
alias CallbackList = List{WgpuCallback};
alias ConstantList = List{WgpuConstant};
