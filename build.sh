#!/usr/bin/env bash
set -e

# Download the WebGPU JSON spec and regenerate C3 bindings
mkdir -p ./assets
curl -L https://raw.githubusercontent.com/webgpu-native/webgpu-headers/main/webgpu.json \
     --output ./assets/webgpu.json

echo "Downloaded webgpu.json"

c3c run build

echo "Done. Generated lib/webgpu.c3 and lib/commands.c3"
