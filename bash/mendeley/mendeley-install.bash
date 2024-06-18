#!/bin/bash

SCRIPT_PATH=$(pwd)
APP=mendeley
DP=~/gitPackages
DAPP=$DP/$APP

VERSION=2.117.0
DOWNLOAD="https://static.mendeley.com/bin/desktop/mendeley-reference-manager-$VERSION-x86_64.AppImage"

install() {
	rm -rf $DAPP
	sudo rm /usr/local/bin/$APP
	mkdir -p $DAPP
	cd $DAPP
	wget -O $APP $DOWNLOAD
	chmod +x $APP
	sudo ln -sr $APP /usr/local/bin/$APP
}

help() {
	echo "
  install"
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
