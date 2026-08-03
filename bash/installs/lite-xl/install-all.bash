#!/bin/bash

TMP=${TMPDIR:-/tmp}
URL_CONFIG=https://github.com/johnnycubides/swissknife/raw/master/bash/installs/lite-xl
LITEX_CONFIG=lite-xl-config
SCRIPT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

download() {
  echo "Remove previous configuration from $TMP"
  rm -rf "$TMP/$LITEX_CONFIG"
  rm -f "$TMP/$LITEX_CONFIG.tar.gz" "$TMP/$LITEX_CONFIG.tar.gz.part"

  mkdir -p "$TMP/$LITEX_CONFIG" || return 1

  wget \
    -O "$TMP/$LITEX_CONFIG.tar.gz.part" \
    "$URL_CONFIG/$LITEX_CONFIG.tar.gz" || return 1

  mv \
    "$TMP/$LITEX_CONFIG.tar.gz.part" \
    "$TMP/$LITEX_CONFIG.tar.gz" || return 1

  tar \
    -xzf "$TMP/$LITEX_CONFIG.tar.gz" \
    -C "$TMP/$LITEX_CONFIG" || return 1
}

finish() {
  echo "Remove downloaded configuration from $TMP"
  rm -rf "$TMP/$LITEX_CONFIG"
  rm -f "$TMP/$LITEX_CONFIG.tar.gz" "$TMP/$LITEX_CONFIG.tar.gz.part"
}

install-lite() {
  echo "==> CONFIGURE download"
  download
  check

  trap finish EXIT
  cd "$TMP/$LITEX_CONFIG"
  check

  echo "==> CONFIGURE remove"
  bash lite-xl-install.bash remove
  check

  echo "==> CONFIGURE install"
  bash lite-xl-install.bash install
  check

  echo "==> CONFIGURE lsp-install"
  bash lite-xl-install.bash lsp-install
  check

  # This plugin still requires adaptations before it can be enabled.
  # echo "==> CONFIGURE build-install"
  # bash lite-xl-install.bash build-install
  # check

  echo "==> CONFIGURE maketoolbar"
  bash lite-xl-install.bash maketoolbar
  check

  echo "==> CONFIGURE build-terminal"
  bash lite-xl-install.bash build-terminal
  check

  echo "==> CONFIGURE config"
  bash lite-xl-install.bash config
  check

  echo "==> CONFIGURE myconfig"
  bash lite-xl-install.bash myconfig
  check

  echo "==> CONFIGURE mkdesktop"
  bash lite-xl-install.bash mkdesktop
  check

  if command -v update-menus >/dev/null 2>&1; then
    update-menus
    check
  fi

  finish
  trap - EXIT
}

all() {
  install-lite
}

pack() {
  cd "$SCRIPT_PATH"
  check

  echo "Package Lite XL configuration"
  rm -f lite-xl-config.tar.gz
  tar \
    -czvf lite-xl-config.tar.gz \
    install-desktop.sh \
    linux \
    lite-xl-install.bash \
    logo.svg \
    myconfig.lua \
    plugins
  check
}

check() {
  local STATUS=$?

  if [[ $STATUS -ne 0 ]]; then
    echo "failed" >&2
    exit "$STATUS"
  fi
}

help() {
  echo "Arguments:"
  echo "  all   Install Lite XL and its configuration"
  echo "  pack  Rebuild lite-xl-config.tar.gz"
}

case "${1:-help}" in
  all)
    all
    ;;
  pack)
    pack
    ;;
  help)
    help
    ;;
  *)
    echo "Unknown argument: $1" >&2
    help
    exit 1
    ;;
esac
