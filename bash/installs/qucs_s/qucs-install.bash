#!/bin/bash

SCRIPT_PATH=$(pwd)
LBIN=/usr/local/bin
APP=qucs
DAPP=~/gitPackages/$APP
IMAGE=Qucs-S-x86_64-Linux.AppImage
VERSION=24.3.2
#DOWNLOAD="https://github.com/ra3xdh/qucs_s/releases/download/$VERSION/Qucs-S-x86_64-Linux.AppImage.zip"
DOWNLOAD="https://github.com/ra3xdh/qucs_s/releases/download/$VERSION/Qucs-S-$VERSION-linux-x86_64.AppImage"

dependencies() {
  # sudo apt update
  sudo apt install \
    ngspice \
    -y
}

install() {
  sudo rm -rf $LBIN/$APP
  rm -rf $DAPP
  mkdir -p $DAPP
  cd $DAPP
  wget -O $IMAGE $DOWNLOAD
  # unzip qucs.zip
  chmod +x $IMAGE
  sudo ln -sr $IMAGE $LBIN/$APP
}

# Agrgar el ejecutable al menu gráfico
mkdesktop() {
  cd $SCRIPT_PATH
  cp ./qucs.png ./install-desktop.sh $DAPP
  cp -r linux $DAPP
  check
  cd $DAPP
  sh install-desktop.sh
  check
}

check() {
  if [[ $? -ne 0 ]]; then
    echo "failed"
    exit $?
  fi
}

help() {
  echo "
dependencies
install
  "
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
