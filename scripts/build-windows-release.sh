#!/usr/bin/env bash
# Build vkim-windows-x64.zip — cross-compiled on Linux/macOS CI
# Usage: bash build-windows-release.sh [nvim-version]
# Example: bash build-windows-release.sh v0.10.4  (default: latest)
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VERSION="${1:-latest}"
OUT_DIR="$REPO_ROOT/dist/vkim-windows-x64"

if [ "$VERSION" = "latest" ]; then
  NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-win64.zip"
else
  NVIM_URL="https://github.com/neovim/neovim/releases/download/${VERSION}/nvim-win64.zip"
fi

echo "Building vkim-windows-x64..."
echo "Neovim: $NVIM_URL"

# Clean output dir
rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR/bin"

# Cross-compile Go launcher
echo "Compiling vkim.exe..."
cd "$REPO_ROOT/launcher/windows"
GOOS=windows GOARCH=amd64 go build -ldflags="-s -w" -o "$OUT_DIR/vkim.exe" .
cd "$REPO_ROOT"

# Download and extract Neovim Win64
echo "Downloading nvim-win64.zip..."
curl -fL "$NVIM_URL" -o /tmp/nvim-win64.zip
unzip -q /tmp/nvim-win64.zip -d "$OUT_DIR/bin"
rm /tmp/nvim-win64.zip

# Normalize extracted dir name to nvim-win64 (zip may extract as nvim-win64-vX.Y.Z)
if ! [ -d "$OUT_DIR/bin/nvim-win64" ]; then
  EXTRACTED=$(ls "$OUT_DIR/bin/" | grep -E '^nvim' | head -1)
  if [ -z "$EXTRACTED" ]; then
    echo "Error: could not find nvim directory in extracted zip. Contents:"
    ls "$OUT_DIR/bin/"
    exit 1
  fi
  mv "$OUT_DIR/bin/$EXTRACTED" "$OUT_DIR/bin/nvim-win64"
fi

# Copy config and fonts
cp -r "$REPO_ROOT/config" "$OUT_DIR/config"
cp -r "$REPO_ROOT/fonts"  "$OUT_DIR/fonts"

# Include Windows Terminal setup script
cp "$REPO_ROOT/setup-windows-terminal.ps1" "$OUT_DIR/setup-windows-terminal.ps1"

# Package
cd "$REPO_ROOT/dist"
zip -r "vkim-windows-x64.zip" "vkim-windows-x64/"
echo ""
echo "Built: dist/vkim-windows-x64.zip ($(du -sh "$REPO_ROOT/dist/vkim-windows-x64.zip" | cut -f1))"
