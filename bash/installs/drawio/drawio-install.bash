#!/bin/bash

LBIN=/usr/local/bin
DP=~/gitPackages/
APP=drawio
DAPP=$DP/$APP
VERSION=24.1.0
DOWNLOAD=https://github.com/jgraph/drawio-desktop/releases/download/v$VERSION/drawio-x86_64-$VERSION.AppImage

dependencies() {
	sudo apt install libfuse2
}

install() {
	sudo rm -i $LBIN/$APP
	mkdir -p $DAPP
	cd $DAPP
	wget -O drawio $DOWNLOAD
	chmod +x $APP
	sudo ln -sr $APP $LBIN/$APP
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
