#!/bin/bash

FILE=$1
BASENAME="${file%.*}"
OUTPUT=$BASENAME.png

function mytinypng() {
  echo "==> START OPTIMAZE PNG"
  rm -f "$OUTPUT"
  pngquant --quality=65-80 --speed 1 --strip "$FILE" --output "$OUTPUT"
  oxipng -o 6 --strip safe "$OUTPUT"
  ls -lh "$OUTPUT"
  echo "==> END OPTIMAZE PNG"
}

help() {
  echo "mytinypng <image.png> # to optimize"
  echo "mytinypng \"image.png\" # Example"

}

if [[ -v 1 ]]; then
  mytinypng
else
  help
fi
