#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"
IMAGE="TikZ.Editor_1.0.0_amd64.AppImage"
APP_DIR="${APP_DIR:-$SCRIPT_DIR}"

# Allow running this repository copy before copying it beside the AppImage.
if [[ ! -f "$APP_DIR/$IMAGE" && "$APP_DIR" == "$SCRIPT_DIR" ]]; then
  APP_DIR="$HOME/gitPackages/tikz-editor/1.0.0"
fi
if [[ ! -x "$APP_DIR/$IMAGE" ]]; then
  printf 'Error: TikZ Editor is not installed or executable: %s\n' "$APP_DIR/$IMAGE" >&2
  exit 1
fi

export GDK_BACKEND=x11
exec "$APP_DIR/$IMAGE" "$@"
