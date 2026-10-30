#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Local entry point. Keep installation logic in one script.
exec bash "$SCRIPT_DIR/tikz-editor-install.bash" "$@"
