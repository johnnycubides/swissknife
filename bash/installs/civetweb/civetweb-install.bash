#! /bin/bash

DIRPACKAGE=~/gitPackages/
APP=civetweb
DIRAPP=$DIRPACKAGE$APP
GITURL="git@github.com:civetweb/civetweb.git"

remove() {
  cd $DIRPACKAGE
  rm -rf $APP
}

download() {
  mkdir -p $DIRPACKAGE
  cd $DIRPACKAGE
  git clone $GITURL
}

build() {
  cd $DIRAPP
  make
}

install() {
  cd $DIRAPP
  sudo make install
}

all() {
  remove
  download
  build
  install
}

help() {
  echo "remove
download
build
install
all
  "
}

if [ "$1" = "help" ] || [ "$1" = "" ]; then
  help
else
  $1
fi
