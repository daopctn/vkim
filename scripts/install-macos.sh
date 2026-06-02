#!/usr/bin/env bash
# vkim macOS installer — for manual installs (CI uses build-macos-release.sh instead)
# Usage: bash install-macos.sh [install-dir]
set -euo pipefail

INSTALL_DIR="${1:-$(pwd)}"
ARCH=$(uname -m)  # arm64 or x86_64
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-macos-${ARCH}.tar.gz"
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "Installing vkim to: $INSTALL_DIR"
echo "Architecture: $ARCH"

mkdir -p "$INSTALL_DIR/bin"

# Download and extract Neovim
echo "Downloading Neovim for macOS ${ARCH}..."
curl -L "$NVIM_URL" | tar -xz -C "$INSTALL_DIR/bin"

# Clear quarantine so macOS doesn't block the binary
xattr -cr "$INSTALL_DIR/bin/"*/bin/nvim 2>/dev/null || true

# Copy config and fonts
cp -r "$SCRIPT_DIR/config" "$INSTALL_DIR/config"
cp -r "$SCRIPT_DIR/fonts"  "$INSTALL_DIR/fonts"

# Install fonts to ~/Library/Fonts (no sudo needed)
echo "Installing fonts to ~/Library/Fonts..."
mkdir -p "$HOME/Library/Fonts"
cp "$INSTALL_DIR/fonts/"*.ttf "$HOME/Library/Fonts/" 2>/dev/null || true

# Create launcher
cp "$SCRIPT_DIR/scripts/launch-macos.sh" "$INSTALL_DIR/vkim.sh"
chmod +x "$INSTALL_DIR/vkim.sh"

# Offer to copy terminal configs (prompt — don't overwrite silently)
prompt_copy() {
  local src="$1" dest="$2" label="$3"
  if [ -f "$src" ] || [ -d "$src" ]; then
    if [ -e "$dest" ]; then
      read -rp "  $label already exists at $dest. Overwrite? [y/N] " ans
      [[ "$ans" =~ ^[Yy]$ ]] || return 0
    fi
    if [ -d "$src" ]; then
      mkdir -p "$dest"
      cp -r "$src/." "$dest/"
    else
      mkdir -p "$(dirname "$dest")"
      cp "$src" "$dest"
    fi
    echo "  Copied $label"
  fi
}

echo ""
echo "Terminal config setup (optional):"
prompt_copy "$SCRIPT_DIR/config/ghostty"      "$HOME/.config/ghostty"          "ghostty config"
prompt_copy "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/starship.toml"   "starship config"
prompt_copy "$SCRIPT_DIR/config/btop"         "$HOME/.config/btop"             "btop config"

echo ""
echo "Done! Run vkim with:"
echo "  $INSTALL_DIR/vkim.sh"
