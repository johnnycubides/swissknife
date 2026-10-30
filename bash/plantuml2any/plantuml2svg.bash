#!/usr/bin/env bash
set -euo pipefail

PLANTUML_BIN="${PLANTUML_BIN:-plantuml}"
TEMP_OUTPUT=""

help() {
  cat <<'EOF'
Usage: plantuml2svg INPUT.puml|INPUT.plantuml [OUTPUT.svg]

Render one PlantUML diagram to SVG. Default output: INPUT.svg.
Relative includes are resolved from the source directory.
Use one @startuml / @enduml diagram per source file.
Source metadata is not embedded in the output.
Set PLANTUML_BIN to select another PlantUML executable.
Existing output is replaced only after successful rendering.
EOF
}

plantuml2svg() {
  local input="$1"
  local output="${2:-${input%.*}.svg}"
  local source_dir source_name

  if [[ ! -f "$input" ]]; then
    printf 'Error: source not found: %s\n' "$input" >&2
    return 1
  fi
  case "$input" in
    *.puml|*.plantuml) ;;
    *) echo 'Error: source must end in .puml or .plantuml.' >&2; return 1 ;;
  esac
  if [[ "$output" != *.svg || ! -d "$(dirname -- "$output")" ]]; then
    echo 'Error: output must end in .svg and its directory must exist.' >&2
    return 1
  fi
  if [[ "$input" -ef "$output" ]]; then
    echo 'Error: input and output must be different files.' >&2
    return 1
  fi
  if ! command -v "$PLANTUML_BIN" >/dev/null 2>&1; then
    echo 'Error: PlantUML missing. Run plantuml2any-install.bash dependencies.' >&2
    return 1
  fi

  source_dir="$(cd -- "$(dirname -- "$input")" && pwd)"
  source_name="$(basename -- "$input")"
  TEMP_OUTPUT="$(mktemp -- "${output}.tmp.XXXXXX")"
  trap 'rm -f -- "$TEMP_OUTPUT"' EXIT
  # Pipe input to avoid output names controlled by @startuml or source filenames.
  if ! (cd -- "$source_dir" && "$PLANTUML_BIN" -tsvg -pipe -nometadata \
      -failfast2 < "$source_name") > "$TEMP_OUTPUT"; then
    echo 'Error: PlantUML rendering failed; existing output was preserved.' >&2
    return 1
  fi
  if [[ ! -s "$TEMP_OUTPUT" ]] || ! grep -q '<svg' "$TEMP_OUTPUT"; then
    echo 'Error: PlantUML did not produce an SVG.' >&2
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
plantuml2svg "$@"
