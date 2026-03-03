#!/usr/bin/env bash
set -e

# Download the WebGPU JSON spec from the official webgpu-native/webgpu-headers repo
mkdir -p ./assets
curl -L https://raw.githubusercontent.com/webgpu-native/webgpu-headers/main/webgpu.json \
     --output ./assets/webgpu.json

echo "Downloaded webgpu.json"

# Compile and run the parser/generator
c3c run build

echo "Done. Generated lib/webgpu.c3 and lib/commands.c3"
