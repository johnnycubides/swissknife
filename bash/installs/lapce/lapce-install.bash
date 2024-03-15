#!/bin/bash

DP=~/gitPackages/
APP=$DP/lapce
DOWNLOAD=https://github.com/lapce/lapce/releases/latest/download/Lapce-linux.tar.gz

install() {
	rm -rf $APP
	mkdir -p $APP
	cd $APP
	wget -O lapce.tar.gz $DOWNLOAD
	tar xvf lapce.tar.gz
	cd Lapce
	chmod +x lapce
	sudo ln -sr lapce /usr/local/bin/lapce
}

# install
