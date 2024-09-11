#!/bin/bash

TMP_LITE=/tmp/lite-xl
URL_CONFIG=
LITEX_CONFIG=lite-xl-config

download() {
  rm -rf $TMP_LITE
  mkdir -p $TMP_LITE
  cd $TMP_LITE
  wget $URL_CONFIG/${LITEX_CONFIG}.tar.gz
  tar xvf $LITEX_CONFIG.tar.gz
}

install-lite() {
  cd $TMP_LITE
  # bash lite-xl-install.bash dependencies
  # check
  echo "==> CONFIGURAR remove"
  bash lite-xl-install.bash remove
  echo "CONFIGURAR install"
  bash lite-xl-install.bash install
  check
  echo "==> CONFIGURAR lsp-install"
  bash lite-xl-install.bash lsp-install
  check
  # echo "==> CONFIGURAR build-install"
  # bash lite-xl-install.bash build-install
  # check
  echo "==> CONFIGURAR build-terminal"
  bash lite-xl-install.bash build-terminal
  check
  echo "==> CONFIGURAR config"
  bash lite-xl-install.bash config
  check
  echo "==> CONFIGURAR myconfig"
  bash lite-xl-install.bash myconfig
  check
  echo "==> CONFIGURAR mkdesktop"
  bash lite-xl-install.bash mkdesktop
  check
}

all() {
  install-lite
}

pack() {
  tar cvf lite-xl-config.tar.gz install-desktop.sh linux lite-xl-install.bash logo.svg myconfig.lua plugins
}

check() {
  if [[ $? -ne 0 ]]; then
    echo "failed"
    exit $?
  fi
}

help() {
  echo "all"
}

# if [[ -v 1 ]]; then
#   $1
# else
#   help
# fi

all
