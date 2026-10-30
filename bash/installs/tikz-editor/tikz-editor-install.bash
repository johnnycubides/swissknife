#!/usr/bin/env bash
set -euo pipefail

APP="tikz-editor"
VERSION="1.0.0"
IMAGE="TikZ.Editor_${VERSION}_amd64.AppImage"
DOWNLOAD="https://github.com/DominikPeters/tikz-editor/releases/download/app-v${VERSION}/${IMAGE}"
SHA256="d0296e685404ebaac23780890d9b371beac947883164d0c28c74029a4e4c4389"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="${APP_DIR:-$HOME/gitPackages/$APP/$VERSION}"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"
DESKTOP_DIR="${DESKTOP_DIR:-$HOME/.local/share/applications}"
TEMP_DIR=""

for directory in "$APP_DIR" "$BIN_DIR" "$DESKTOP_DIR"; do
  if [[ "$directory" != /* ]]; then
    echo 'Error: APP_DIR, BIN_DIR and DESKTOP_DIR must be absolute paths.' >&2
    exit 2
  fi
done

dependencies() {
  if ! command -v apt >/dev/null 2>&1; then
    echo 'Install curl, CA certificates and FUSE 2 with your package manager.' >&2
    return 1
  fi
  local fuse_package="libfuse2"
  if apt-cache show libfuse2t64 >/dev/null 2>&1; then
    fuse_package="libfuse2t64"
  fi
  sudo apt install curl ca-certificates "$fuse_package"
}

install() {
  local target="$BIN_DIR/$APP"
  local executable="$APP_DIR/$IMAGE"
  local launcher="$APP_DIR/tikz-editor.bash"

  if [[ "$(uname -m)" != x86_64 ]]; then
    echo 'Error: this installer supports Linux x86_64 only.' >&2
    return 1
  fi
  if ! command -v curl >/dev/null 2>&1; then
    echo 'Error: curl is required. Run dependencies first.' >&2
    return 1
  fi
  if [[ -e "$target" || -L "$target" ]]; then
    if [[ ! -L "$target" ]] || { [[ "$(readlink -- "$target")" != "$executable" ]] && [[ "$(readlink -- "$target")" != "$launcher" ]]; }; then
      printf 'Error: refusing to replace an existing file or link: %s\n' "$target" >&2
      return 1
    fi
  fi
  if [[ -L "$executable" ]]; then
    echo 'Error: the application destination must not be a symlink.' >&2
    return 1
  fi
  if [[ -e "$executable" ]]; then
    printf '%s  %s\n' "$SHA256" "$executable" | sha256sum --check --status
    printf 'Verified existing application: %s\n' "$executable"
  else
    TEMP_DIR="$(mktemp -d)"
    trap 'rm -rf -- "$TEMP_DIR"' EXIT
    curl --fail --location --retry 3 --output "$TEMP_DIR/$IMAGE" "$DOWNLOAD"
    printf '%s  %s\n' "$SHA256" "$TEMP_DIR/$IMAGE" | sha256sum --check
    mkdir -p -- "$APP_DIR"
    cp -- "$TEMP_DIR/$IMAGE" "$executable"
  fi
  chmod +x -- "$executable"
  cp -- "$SCRIPT_DIR/tikz-editor.bash" "$launcher"
  chmod +x -- "$launcher"
  mkdir -p -- "$BIN_DIR"
  # Replace only a link already verified as belonging to this installation.
  ln -sfn -- "$launcher" "$target"
  printf 'Installed: %s\n' "$target"
  case ":$PATH:" in
    *":$BIN_DIR:"*) ;;
    *) printf 'Add this directory to PATH if needed: %s\n' "$BIN_DIR" ;;
  esac
}

mkdesktop() {
  local desktop="$DESKTOP_DIR/$APP.desktop"
  if [[ ! -x "$APP_DIR/tikz-editor.bash" ]]; then
    echo 'Error: run install before mkdesktop.' >&2
    return 1
  fi
  if [[ -e "$desktop" || -L "$desktop" ]]; then
    if [[ -L "$desktop" ]] || ! grep -Fxq "Exec=\"$APP_DIR/$IMAGE\" %F" "$desktop"; then
      printf 'Error: refusing to replace an existing desktop entry: %s\n' "$desktop" >&2
      return 1
    fi
  fi
  cp -- "$SCRIPT_DIR/tikz-editor.svg" "$APP_DIR/tikz-editor.svg"
  mkdir -p -- "$DESKTOP_DIR"
  cat > "$desktop" <<EOF
[Desktop Entry]
Type=Application
Name=TikZ Editor
Comment=Visual editor for TikZ diagrams and LaTeX figures
Exec="$APP_DIR/tikz-editor.bash" %F
Icon=$APP_DIR/tikz-editor.svg
Terminal=false
Categories=Graphics;Education;
Keywords=TikZ;LaTeX;diagram;vector;
EOF
  if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$DESKTOP_DIR"
  fi
  printf 'Created desktop entry: %s\n' "$desktop"
}

all() {
  dependencies
  install
  mkdesktop
}

help() {
  cat <<'EOF'
Usage: tikz-editor-install.bash [dependencies|install|mkdesktop|all|help]

  dependencies  Install curl, CA certificates and FUSE 2 using apt (sudo).
  install       Download version 1.0.0, verify SHA256 and create a command link.
  mkdesktop     Create a per-user application menu entry after install.
  all           Run dependencies, install and mkdesktop.
  help          Show this help (default).

Defaults:
  APP_DIR      ~/gitPackages/tikz-editor/1.0.0
  BIN_DIR      ~/.local/bin
  DESKTOP_DIR  ~/.local/share/applications

Override these directories with absolute paths through environment variables.
Existing unrelated commands and desktop entries are never overwritten.
No application is launched automatically.
EOF
}

if [[ $# -gt 1 ]]; then
  help >&2
  exit 2
fi
case "${1:-help}" in
  dependencies|install|mkdesktop|all) "$1" ;;
  help|-h|--help) help ;;
  *) echo "Error: unknown action: $1" >&2; help >&2; exit 2 ;;
esac
