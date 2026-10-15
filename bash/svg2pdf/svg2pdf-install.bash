#!/usr/bin/env bash
set -euo pipefail

APP_NAME="svg2pdf"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"

dependencies() {
  if command -v inkscape >/dev/null 2>&1; then
    echo "Inkscape is already available."
    return
  fi
  if ! command -v apt >/dev/null 2>&1; then
    echo "Install Inkscape with your system package manager, then run install." >&2
    return 1
  fi
  # Acción explícita para Debian/Ubuntu; install no ejecuta este paso.
  sudo apt install inkscape
}

install() {
  local source="$SCRIPT_DIR/$APP_NAME.bash"
  local target="$INSTALL_DIR/$APP_NAME"

  if [[ ! -x "$source" ]]; then
    printf 'Error: converter script is missing or not executable: %s\n' "$source" >&2
    return 1
  fi
  if [[ -L "$target" && "$(readlink -- "$target")" == "$source" ]]; then
    printf 'Already installed: %s\n' "$target"
    return
  fi
  if [[ -e "$target" || -L "$target" ]]; then
    printf 'Error: refusing to replace an existing file or link: %s\n' "$target" >&2
    return 1
  fi
  mkdir -p -- "$INSTALL_DIR"
  ln -s -- "$source" "$target"
  printf 'Installed: %s\n' "$target"
  case ":$PATH:" in
    *":$INSTALL_DIR:"*) ;;
    *) printf 'Add this directory to PATH if needed: %s\n' "$INSTALL_DIR" ;;
  esac
}

all() {
  dependencies
  install
}

help() {
  cat <<'EOF'
Usage: svg2pdf-install.bash [dependencies|install|all|help]

  dependencies  Install Inkscape with apt if it is missing (Debian/Ubuntu).
  install       Link svg2pdf into ~/.local/bin; no sudo or shell edits.
  all           Run dependencies, then install.
  help          Show this help (default).

Override the destination: INSTALL_DIR=/path/to/bin ./svg2pdf-install.bash install
EOF
}

if [[ $# -gt 1 ]]; then
  help >&2
  exit 2
fi

case "${1:-help}" in
  dependencies|install|all) "$1" ;;
  help|-h|--help) help ;;
  *) echo "Error: unknown action: $1" >&2; help >&2; exit 2 ;;
esac
