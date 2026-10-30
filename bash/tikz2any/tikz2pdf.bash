#!/usr/bin/env bash
set -euo pipefail

LATEX_BIN="${LATEX_BIN:-lualatex}"
TIKZ_PREAMBLE="${TIKZ_PREAMBLE:-}"
TEMP_DIR=""
TEMP_OUTPUT=""

help() {
  cat <<'EOF'
Usage: tikz2pdf INPUT.tikz|INPUT.tex [OUTPUT.pdf]

Compile a TikZ fragment or a complete LaTeX document.
The default output is INPUT.pdf, beside the source.

.tikz files must contain a tikzpicture, without a document preamble.
.tex files must be complete documents. Their page size is preserved.
Relative includes and images are resolved from the source directory.

Environment:
  LATEX_BIN       LaTeX engine (default: lualatex).
  TIKZ_PREAMBLE   Optional preamble file for .tikz fragments, resolved from
                  the calling directory. Add packages, libraries and styles.

Existing output is replaced only after successful compilation.
Auxiliary files are temporary. Shell escape is disabled.
EOF
}

tikz2pdf() {
  local input="$1"
  local output="${2:-${input%.*}.pdf}"
  local source_dir source_name extension

  if [[ ! -f "$input" ]]; then
    printf 'Error: source not found: %s\n' "$input" >&2
    return 1
  fi
  extension="${input##*.}"
  if [[ "$extension" != tikz && "$extension" != tex ]]; then
    echo 'Error: source must end in .tikz or .tex.' >&2
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
  if ! command -v "$LATEX_BIN" >/dev/null 2>&1; then
    echo 'Error: LaTeX engine missing. Run tikz2any-install.bash dependencies.' >&2
    return 1
  fi
  if [[ -n "$TIKZ_PREAMBLE" ]]; then
    if [[ ! -f "$TIKZ_PREAMBLE" ]]; then
      echo 'Error: TIKZ_PREAMBLE must name an existing file.' >&2
      return 1
    fi
    TIKZ_PREAMBLE="$(realpath -- "$TIKZ_PREAMBLE")"
  fi

  source_dir="$(cd -- "$(dirname -- "$input")" && pwd)"
  source_name="$(basename -- "$input")"
  TEMP_DIR="$(mktemp -d)"
  TEMP_OUTPUT="$(mktemp -- "${output}.tmp.XXXXXX")"
  trap 'rm -rf -- "$TEMP_DIR"; rm -f -- "$TEMP_OUTPUT"' EXIT

  if [[ "$extension" == tikz ]]; then
    {
      printf '\\documentclass[tikz,border=5mm]{standalone}\n'
      printf '\\usetikzlibrary{arrows.meta,positioning,calc,fit,backgrounds,shapes.geometric}\n'
      if [[ -n "$TIKZ_PREAMBLE" ]]; then
        printf '\\input{\\detokenize{%s}}\n' "$TIKZ_PREAMBLE"
      fi
      printf '\\begin{document}\n\\input{\\detokenize{%s}}\n\\end{document}\n' "$source_name"
    } > "$TEMP_DIR/wrapper.tex"
    input="$TEMP_DIR/wrapper.tex"
  else
    input="$source_dir/$source_name"
  fi

  # Run twice to resolve ordinary LaTeX cross-references.
  for pass in 1 2; do
    if ! (cd -- "$source_dir" && "$LATEX_BIN" -no-shell-escape \
      -interaction=nonstopmode -halt-on-error -jobname=tikz2any \
      -output-directory="$TEMP_DIR" "$input") > "$TEMP_DIR/build.log" 2>&1; then
      cat "$TEMP_DIR/build.log" >&2
      echo 'Error: LaTeX compilation failed; existing output was preserved.' >&2
      return 1
    fi
  done
  if [[ ! -s "$TEMP_DIR/tikz2any.pdf" ]]; then
    echo 'Error: LaTeX did not produce a PDF.' >&2
    return 1
  fi
  cp -- "$TEMP_DIR/tikz2any.pdf" "$TEMP_OUTPUT"
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
tikz2pdf "$@"
