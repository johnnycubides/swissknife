#!/bin/bash

TMP=/tmp/
URL_CONFIG=https://github.com/johnnycubides/swissknife/raw/master/bash/installs/lite-xl
LITEX_CONFIG=lite-xl-config

download() {
  cd $TMP
  echo "Remover anteriores configuracions en $TMP"
  rm -rf $LITEX_CONFIG*
  wget $URL_CONFIG/${LITEX_CONFIG}.tar.gz
  tar xvf $LITEX_CONFIG.tar.gz
}

install-lite() {
  # echo "==> CONFIGURAR dependencies"
  # bash lite-xl-install.bash dependencies
  # check
  echo "==> CONFIGURAR download"
  download
  cd $TMP$LITEX_CONFIG
  echo "==> CONFIGURAR remove"
  bash lite-xl-install.bash remove
  echo "==> CONFIGURAR install"
  bash lite-xl-install.bash install
  check
  echo "==> CONFIGURAR lsp-install"
  bash lite-xl-install.bash lsp-install
  check
  echo "==> CONFIGURAR build-install"
  bash lite-xl-install.bash build-install
  check
  # Aunque este plugin opera correctamente, se requiere algunas adaptaciones para su implementación.
  # echo "==> CONFIGURAR build-terminal"
  # bash lite-xl-install.bash build-terminal
  # check
  echo "==> CONFIGURAR config"
  bash lite-xl-install.bash config
  check
  echo "==> CONFIGURAR myconfig"
  bash lite-xl-install.bash myconfig
  check
  echo "==> CONFIGURAR mkdesktop"
  bash lite-xl-install.bash mkdesktop
  check
  update-menus
}

all() {
  install-lite
}

pack() {
  echo "Packages"
  rm -rf lite-xl-config.tar.gz
  tar -czvf lite-xl-config.tar.gz install-desktop.sh linux lite-xl-install.bash logo.svg myconfig.lua plugins
}

check() {
  if [[ $? -ne 0 ]]; then
    echo "failed"
    exit $?
  fi
}

help() {
  echo "all"
  echo "pack"
}

if [[ -v 1 ]]; then
  $1
else
  help
fi

# all
