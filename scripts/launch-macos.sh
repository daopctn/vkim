#!/usr/bin/env bash
# vkim launcher for macOS — sets isolated XDG dirs then runs nvim
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_BIN=$(ls "$SCRIPT_DIR/bin/"*/bin/nvim 2>/dev/null | head -1)

if [ -z "$NVIM_BIN" ] || [ ! -x "$NVIM_BIN" ]; then
  echo "vkim: nvim not found under $SCRIPT_DIR/bin/" >&2
  echo "      Re-run install-macos.sh or re-extract the tarball." >&2
  exit 1
fi

export NVIM_APPNAME=vkim
export XDG_CONFIG_HOME="$SCRIPT_DIR/config"
export XDG_DATA_HOME="$SCRIPT_DIR/data"
export XDG_STATE_HOME="$SCRIPT_DIR/state"
export XDG_CACHE_HOME="$SCRIPT_DIR/cache"

# Expose Xcode SDK to clangd so it finds system headers without extra config
if command -v xcrun &>/dev/null; then
  _sdk=$(xcrun --sdk macosx --show-sdk-path 2>/dev/null) && export SDKROOT="$_sdk" || true
fi

exec "$NVIM_BIN" "$@"
