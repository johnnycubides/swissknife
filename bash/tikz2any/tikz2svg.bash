#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"
TEMP_DIR=""
TEMP_OUTPUT=""

help() {
  cat <<'EOF'
Usage: tikz2svg INPUT.tikz|INPUT.tex [OUTPUT.svg]

Compile with tikz2pdf and convert the first PDF page to SVG with pdftocairo.
The default output is INPUT.svg, beside the source.
No intermediate PDF is kept. Existing output is preserved on failure.
LATEX_BIN and TIKZ_PREAMBLE work as described in tikz2pdf --help.
EOF
}

tikz2svg() {
  local input="$1"
  local output="${2:-${input%.*}.svg}"

  if ! command -v pdftocairo >/dev/null 2>&1; then
    echo 'Error: pdftocairo missing. Run tikz2any-install.bash dependencies.' >&2
    return 1
  fi
  if [[ "$output" != *.svg || ! -d "$(dirname -- "$output")" ]]; then
    echo 'Error: output must end in .svg and its directory must exist.' >&2
    return 1
  fi
  if [[ "$input" -ef "$output" ]]; then
    echo 'Error: input and output must be different files.' >&2
    return 1
  fi
  TEMP_DIR="$(mktemp -d)"
  TEMP_OUTPUT="$(mktemp -- "${output}.tmp.XXXXXX")"
  trap 'rm -rf -- "$TEMP_DIR"; rm -f -- "$TEMP_OUTPUT"' EXIT

  "$SCRIPT_DIR/tikz2pdf.bash" "$input" "$TEMP_DIR/diagram.pdf"
  pdftocairo -svg -f 1 -l 1 "$TEMP_DIR/diagram.pdf" "$TEMP_OUTPUT"
  if [[ ! -s "$TEMP_OUTPUT" ]]; then
    echo 'Error: pdftocairo did not produce an SVG.' >&2
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
tikz2svg "$@"
