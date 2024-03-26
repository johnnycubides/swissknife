#!/bin/bash

LBIN=/usr/local/bin
APP=qucs
DAPP=~/gitPackages/$APP
IMAGE=Qucs-S-x86_64-Linux.AppImage
VERSION=24.1.0
DOWNLOAD="https://github.com/ra3xdh/qucs_s/releases/download/$VERSION/Qucs-S-x86_64-Linux.AppImage.zip"

dependencies() {
	sudo apt update
	sudo apt install \
		unzip \
		ngspice \
		-y
}

install() {
	sudo rm -rf $LBIN/$APP
	rm -r -i $DAPP
	mkdir -p $DAPP
	cd $DAPP
	wget -O qucs.zip $DOWNLOAD
	unzip qucs.zip
	chmod +x $IMAGE
	sudo ln -sr $IMAGE $LBIN/$APP
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
