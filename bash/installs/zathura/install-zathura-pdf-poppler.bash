#!/bin/bash

APP=zathura-pdf-poppler
DAPP=~/gitPackages/$APP
VERSION=0.3.3
DOWNLOAD=https://github.com/pwmt/$APP/archive/refs/tags/$VERSION.tar.gz

dependencies() {
  sudo apt update
  sudo apt install \
    fish \
    libpoppler-glib-dev \
    meson \
    gettext \
    pkgconf \
    check \
    appstream-util \
    -y
  echo "Además de lo anterior, debe instalar girara y zathura visor"
}

download() {
  mkdir -p $DAPP
  cd $DAPP
  wget -O $APP.tar.gz $DOWNLOAD
  tar xvf $APP.tar.gz
}

build() {
  cd $DAPP/$APP-$VERSION
  meson setup --reconfigure build
  cd build
  ninja
}

install() {
  cd $DAPP/$APP-$VERSION/build
  sudo ninja install
}

remove() {
  rm -rf $DAPP
}

help() {
  echo "
dependencies
download
build
install
remove
  "
}

all() {
  dependencies
  download
  build
  install
  remove
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
