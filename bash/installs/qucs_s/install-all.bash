#!/bin/bash

TMP=/tmp/
QUCS_CONFIG=qucs_s
URL_CONFIG=https://github.com/johnnycubides/swissknife/raw/master/bash/installs/$QUCS_CONFIG

download() {
  cd $TMP
  rm -rf $QUCS_CONFIG.tar.gz
  wget $URL_CONFIG/${QUCS_CONFIG}.tar.gz
  tar xvf $QUCS_CONFIG.tar.gz
}

install-qucs() {
  # echo "==> CONFIGURAR dependencies"
  # bash lite-xl-install.bash dependencies
  # check
  echo "==> CONFIGURAR download"
  download
  cd $TMP/$QUCS_CONFIG
  echo "==> INSTALAR Qucs_s"
  bash qucs-install.bash install
  check
  echo "==> CONFIGURAR mkdesktop"
  bash qucs-install.bash mkdesktop
  check
  update-menus
}

all() {
  install-qucs
}

pack() {
  tar -czvf $QUCS_CONFIG.tar.gz install-desktop.sh linux qucs-install.bash qucs.png
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

if [[ -v 1 ]]; then
  $1
else
  help
fi

# all
