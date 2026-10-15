#!/usr/bin/env bash
set -euo pipefail

INKSCAPE_BIN="${INKSCAPE_BIN:-inkscape}"
EXPORT_AREA="--export-area-drawing"
TEMP_OUTPUT="" # Global para que el trap EXIT pueda limpiarlo aun al salir de la función.

help() {
  cat <<'EOF'
Usage: svg2pdf [--drawing|--page] INPUT.svg [OUTPUT.pdf]

  --drawing  Export the drawing bounds (default, useful for diagrams).
  --page     Export the whole page (useful for book covers).
  --help     Show this help.

The default output is INPUT.pdf, beside the SVG. An existing output PDF
is replaced only after a successful export. The SVG is not modified.

Examples:
  svg2pdf "circuit diagram.svg"
  svg2pdf --page cover.svg cover-background.pdf
EOF
}

svg2pdf() {
  local input="$1"
  local output="${2:-${input%.*}.pdf}"

  if ! command -v "$INKSCAPE_BIN" >/dev/null 2>&1; then
    echo "Error: Inkscape is required. Run svg2pdf-install.bash dependencies." >&2
    return 1
  fi
  if [[ ! -f "$input" || "${input,,}" != *.svg ]]; then
    echo "Error: input must be an existing SVG file: $input" >&2
    return 1
  fi
  if [[ "${output,,}" != *.pdf || ! -d "$(dirname -- "$output")" ]]; then
    echo "Error: output must end in .pdf and its directory must exist: $output" >&2
    return 1
  fi
  if [[ "$input" -ef "$output" ]]; then
    echo "Error: input and output must be different files." >&2
    return 1
  fi

  # Exportar primero a un archivo temporal: conservar el PDF anterior si falla.
  TEMP_OUTPUT="$(mktemp --suffix=.pdf "${output}.tmp.XXXXXX")"
  trap 'rm -f -- "$TEMP_OUTPUT"' EXIT
  "$INKSCAPE_BIN" "$EXPORT_AREA" --export-type=pdf --export-filename="$TEMP_OUTPUT" -- "$input"
  if [[ ! -s "$TEMP_OUTPUT" ]]; then
    echo "Error: Inkscape did not produce a PDF." >&2
    return 1
  fi
  mv -f -- "$TEMP_OUTPUT" "$output"
  trap - EXIT
  printf 'Created: %s\n' "$output"
}

case "${1:-help}" in
  help|-h|--help) help; exit 0 ;;
  --page) EXPORT_AREA="--export-area-page"; shift ;;
  --drawing) shift ;;
  --*) echo "Error: unknown option: $1" >&2; exit 2 ;;
esac

if [[ $# -lt 1 || $# -gt 2 ]]; then
  help >&2
  exit 2
fi
svg2pdf "$@"
