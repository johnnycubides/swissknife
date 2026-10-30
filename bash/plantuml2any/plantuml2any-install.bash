#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"

dependencies() {
  if command -v plantuml >/dev/null 2>&1 && command -v java >/dev/null 2>&1 \
    && command -v dot >/dev/null 2>&1 && command -v inkscape >/dev/null 2>&1; then
    echo 'Dependencies are already available.'
    return
  fi
  if ! command -v apt >/dev/null 2>&1; then
    echo 'Install PlantUML, Java, Graphviz and Inkscape with your package manager.' >&2
    return 1
  fi
  # Keep existing custom installations; only request packages for missing tools.
  local packages=()
  command -v plantuml >/dev/null 2>&1 || packages+=(plantuml)
  command -v java >/dev/null 2>&1 || packages+=(default-jre-headless)
  command -v dot >/dev/null 2>&1 || packages+=(graphviz)
  command -v inkscape >/dev/null 2>&1 || packages+=(inkscape)
  sudo apt install "${packages[@]}"
}

install() {
  local name source target
  for name in plantuml2svg plantuml2pdf; do
    source="$SCRIPT_DIR/$name.bash"
    target="$INSTALL_DIR/$name"
    if [[ ! -x "$source" ]]; then
      printf 'Error: script missing or not executable: %s\n' "$source" >&2
      return 1
    fi
    if [[ -L "$target" && "$(readlink -- "$target")" == "$source" ]]; then
      continue
    fi
    if [[ -e "$target" || -L "$target" ]]; then
      printf 'Error: refusing to replace existing file or link: %s\n' "$target" >&2
      return 1
    fi
  done
  mkdir -p -- "$INSTALL_DIR"
  for name in plantuml2svg plantuml2pdf; do
    if [[ -L "$INSTALL_DIR/$name" ]]; then
      printf 'Already installed: %s\n' "$INSTALL_DIR/$name"
    else
      ln -s -- "$SCRIPT_DIR/$name.bash" "$INSTALL_DIR/$name"
      printf 'Installed: %s\n' "$INSTALL_DIR/$name"
    fi
  done
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
Usage: plantuml2any-install.bash [dependencies|install|all|help]

  dependencies  Install missing tools with apt (Debian/Ubuntu).
  install       Link plantuml2svg and plantuml2pdf into ~/.local/bin.
  all           Run dependencies, then install.
  help          Show this help (default).

install does not use sudo, replace files or edit shell configuration.
Override the link directory with INSTALL_DIR=/path/to/bin.
Keep this source directory in place after linking.
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
