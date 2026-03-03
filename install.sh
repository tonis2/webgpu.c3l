#!/usr/bin/env bash
set -e

# Download wgpu-native binaries for the current platform into ./libs/wgpu-native/

OS=$(uname -s)
ARCH=$(uname -m)

case "$OS" in
    Linux)
        case "$ARCH" in
            x86_64)  WGPU_ASSET="wgpu-linux-x86_64-release.zip" ;;
            aarch64) WGPU_ASSET="wgpu-linux-aarch64-release.zip" ;;
            *)        echo "Unsupported Linux architecture: $ARCH"; exit 1 ;;
        esac
        ;;
    Darwin)
        case "$ARCH" in
            x86_64)  WGPU_ASSET="wgpu-macos-x86_64-release.zip" ;;
            arm64)   WGPU_ASSET="wgpu-macos-aarch64-release.zip" ;;
            *)        echo "Unsupported macOS architecture: $ARCH"; exit 1 ;;
        esac
        ;;
    MINGW*|MSYS*|CYGWIN*)
        case "$ARCH" in
            x86_64)  WGPU_ASSET="wgpu-windows-x86_64-release.zip" ;;
            *)        echo "Unsupported Windows architecture: $ARCH"; exit 1 ;;
        esac
        ;;
    *)
        echo "Unsupported OS: $OS"; exit 1 ;;
esac

WGPU_VERSION=$(curl -s "https://api.github.com/repos/gfx-rs/wgpu-native/releases/latest" \
    | python3 -c "import json,sys; print(json.load(sys.stdin)['tag_name'])")

echo "Downloading wgpu-native ${WGPU_VERSION} for ${OS}/${ARCH}..."
mkdir -p ./libs/wgpu-native
curl -L "https://github.com/gfx-rs/wgpu-native/releases/download/${WGPU_VERSION}/${WGPU_ASSET}" \
     -o /tmp/wgpu-native.zip
unzip -o /tmp/wgpu-native.zip -d ./libs/wgpu-native/

echo "Done. Libraries installed to ./libs/wgpu-native/"
