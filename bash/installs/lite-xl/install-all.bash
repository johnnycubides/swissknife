#!/bin/bash

TMP=/tmp/lite-xl
URL_CONFIG=
LITEX_CONFIG=lite-xl-config

download() {
  rm -rf $TMP
  mkdir -p $TMP
  cd $TMP
  wget $URL_CONFIG/${LITEX_CONFIG}.tar.gz
  tar xvf $LITEX_CONFIG.tar.gz
}

install-lite() {
  cd $TMP
  bash lite-xl-install.bash dependencies
  check
  bash lite-xl-install.bash remove
  bash lite-xl-install.bash install
  check
  bash lite-xl-install.bash lsp-install
  check
  bash lite-xl-install.bash build-install
  check
  bash lite-xl-install.bash config
  check
  bash lite-xl-install.bash myconfig
  check
  bash lite-xl-install.bash mkdesktop
  check
}

all() {
  install-all
}

all

pack() {
  tar cvf lite-xl-config.tar.gz install-desktop.sh linux lite-xl-install.bash logo.svg myconfig.lua plugins
}

check() {
  if [[ $? -ne 0 ]]; then
    exit $?
  fi
}

help() {
  echo "all"
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
