#!/usr/bin/env bash
# Build vkim-macos-{arch}.tar.gz for CI release
# Usage: bash build-macos-release.sh [arm64|x86_64] [nvim-version]
# Example: bash build-macos-release.sh arm64 v0.10.4  (default: host arch, latest nvim)
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ARCH="${1:-$(uname -m)}"
VERSION="${2:-latest}"
OUT_DIR="$REPO_ROOT/dist/vkim-macos-${ARCH}"

if [ "$VERSION" = "latest" ]; then
  NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-macos-${ARCH}.tar.gz"
else
  NVIM_URL="https://github.com/neovim/neovim/releases/download/${VERSION}/nvim-macos-${ARCH}.tar.gz"
fi

echo "Building vkim-macos-${ARCH}..."
echo "Neovim: $NVIM_URL"

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR/bin"

# Download and extract Neovim
echo "Downloading nvim-macos-${ARCH}.tar.gz..."
curl -fL "$NVIM_URL" | tar -xz -C "$OUT_DIR/bin"

# Clear quarantine (CI runner — does not affect end-user's quarantine on download)
xattr -cr "$OUT_DIR/bin/"*/bin/nvim 2>/dev/null || true

# Copy config and fonts
cp -r "$REPO_ROOT/config" "$OUT_DIR/config"
cp -r "$REPO_ROOT/fonts"  "$OUT_DIR/fonts"

# Install launcher
cp "$REPO_ROOT/scripts/launch-macos.sh" "$OUT_DIR/vkim.sh"
chmod +x "$OUT_DIR/vkim.sh"

# Package
cd "$REPO_ROOT/dist"
tar -czf "vkim-macos-${ARCH}.tar.gz" "vkim-macos-${ARCH}/"
echo ""
echo "Built: dist/vkim-macos-${ARCH}.tar.gz ($(du -sh "$REPO_ROOT/dist/vkim-macos-${ARCH}.tar.gz" | cut -f1))"
