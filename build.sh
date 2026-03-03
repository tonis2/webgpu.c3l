#!/usr/bin/env bash
set -e

# Download the WebGPU JSON spec from the official webgpu-native/webgpu-headers repo
mkdir -p ./assets
curl -L https://raw.githubusercontent.com/webgpu-native/webgpu-headers/main/webgpu.json \
     --output ./assets/webgpu.json

echo "Downloaded webgpu.json"

# Download wgpu-native binaries (Linux x64) if not already present
if [ ! -f "./libs/wgpu-native/lib/libwgpu_native.so" ]; then
    echo "Downloading wgpu-native..."
    WGPU_VERSION=$(curl -s "https://api.github.com/repos/gfx-rs/wgpu-native/releases/latest" \
        | python3 -c "import json,sys; print(json.load(sys.stdin)['tag_name'])")
    mkdir -p ./libs/wgpu-native
    curl -L "https://github.com/gfx-rs/wgpu-native/releases/download/${WGPU_VERSION}/wgpu-linux-x86_64-release.zip" \
         -o /tmp/wgpu-native.zip
    unzip -o /tmp/wgpu-native.zip -d ./libs/wgpu-native/
    echo "Downloaded wgpu-native ${WGPU_VERSION}"
fi

# Compile and run the parser/generator
c3c run build

echo "Done. Generated lib/webgpu.c3 and lib/commands.c3"
