#!/usr/bin/env bash
# Package existing AppImage into dist/ for CI release
# Usage: bash build-linux-release.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
APPIMAGE="$REPO_ROOT/Vkim-x86_64.AppImage"

if [ ! -f "$APPIMAGE" ]; then
  echo "Error: $APPIMAGE not found."
  echo "Build the AppImage first before running this script."
  exit 1
fi

mkdir -p "$REPO_ROOT/dist"
cp "$APPIMAGE" "$REPO_ROOT/dist/Vkim-x86_64.AppImage"
echo "Built: dist/Vkim-x86_64.AppImage ($(du -sh "$REPO_ROOT/dist/Vkim-x86_64.AppImage" | cut -f1))"
