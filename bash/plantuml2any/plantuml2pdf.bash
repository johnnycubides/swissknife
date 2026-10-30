#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"
INKSCAPE_BIN="${INKSCAPE_BIN:-inkscape}"
TEMP_DIR=""
TEMP_OUTPUT=""

help() {
  cat <<'EOF'
Usage: plantuml2pdf INPUT.puml|INPUT.plantuml [OUTPUT.pdf]

Render one diagram with plantuml2svg, then export its SVG page with Inkscape.
Default output: INPUT.pdf. No intermediate SVG is kept.
Existing output is preserved on failure.
PLANTUML_BIN selects PlantUML; INKSCAPE_BIN selects Inkscape.
EOF
}

plantuml2pdf() {
  local input="$1"
  local output="${2:-${input%.*}.pdf}"

  if ! command -v "$INKSCAPE_BIN" >/dev/null 2>&1; then
    echo 'Error: Inkscape missing. Run plantuml2any-install.bash dependencies.' >&2
    return 1
  fi
  if [[ "$output" != *.pdf || ! -d "$(dirname -- "$output")" ]]; then
    echo 'Error: output must end in .pdf and its directory must exist.' >&2
    return 1
  fi
  if [[ "$input" -ef "$output" ]]; then
    echo 'Error: input and output must be different files.' >&2
    return 1
  fi
  TEMP_DIR="$(mktemp -d)"
  TEMP_OUTPUT="$(mktemp --suffix=.pdf "${output}.tmp.XXXXXX")"
  trap 'rm -rf -- "$TEMP_DIR"; rm -f -- "$TEMP_OUTPUT"' EXIT

  "$SCRIPT_DIR/plantuml2svg.bash" "$input" "$TEMP_DIR/diagram.svg"
  "$INKSCAPE_BIN" --export-area-page --export-type=pdf \
    --export-filename="$TEMP_OUTPUT" -- "$TEMP_DIR/diagram.svg"
  if [[ ! -s "$TEMP_OUTPUT" ]]; then
    echo 'Error: Inkscape did not produce a PDF.' >&2
    return 1
  fi
  mv -f -- "$TEMP_OUTPUT" "$output"
  printf 'Created: %s\n' "$output"
}

case "${1:-help}" in
  help|-h|--help) help; exit 0 ;;
esac
if [[ $# -lt 1 || $# -gt 2 ]]; then
  help >&2
  exit 2
fi
plantuml2pdf "$@"
