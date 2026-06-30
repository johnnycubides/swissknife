#!/usr/bin/env bash

KICAD_APPIMAGE=kicad9

exec /usr/local/bin/$KICAD_APPIMAGE --appimage-extract-and-run kicad-cli "$@"
