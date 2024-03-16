#!/bin/bash

VERSION=v2.1.3

DOWNLOAD=https://github.com/lite-xl/lite-xl/releases/download/$VERSION/lite-xl-$VERSION-addons-linux-x86_64-portable.tar.gz

DP=~/gitPackages/
APP=$DP/lite-xl
BIN=/usr/local/bin/

remove() {
	rm -rf $APP
	rm -rf ~/.config/lite-xl
	sudo rm $BIN/lite-xl
}

install() {
	rm -rf $APP
	mkdir -p $APP
	cd $APP
	wget -O lite-xl.tar.gz $DOWNLOAD
	tar xvf lite-xl.tar.gz
	rm lite-xl.tar.gz
	cd lite-xl
	sudo ln -sr ./lite-xl $BIN/lite-xl
}

# install
# remove
