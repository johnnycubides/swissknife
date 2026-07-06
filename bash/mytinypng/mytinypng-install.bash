#!/bin/bash

APP_NAME=mytinypng

dependencies() {
  sudo apt install pngquant
  check
  cargo install oxipng
  check
}

install() {
  URL_BIN=/usr/local/bin/
  sudo rm $URL_BIN$APP_NAME
  sudo ln -sr ./$APP_NAME.bash $URL_BIN$APP_NAME
}

check() {
  if [[ $? -ne 0 ]]; then
    echo "failed"
    exit $?
  fi
}

help() {
  echo "install"
  echo "dependencies"
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
