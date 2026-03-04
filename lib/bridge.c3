module wgpu;

const char[] BRIDGE_JS = $embed("webgpu.js");

fn char* get_bridge_js() @export("get_bridge_js") {
    return &BRIDGE_JS[0];
}

fn uint get_bridge_js_len() @export("get_bridge_js_len") {
    return (uint)BRIDGE_JS.len;
}
