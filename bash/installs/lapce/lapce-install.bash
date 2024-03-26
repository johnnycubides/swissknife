#!/bin/bash

DP=~/gitPackages/
APP=$DP/lapce
DOWNLOAD=https://github.com/lapce/lapce/releases/latest/download/Lapce-linux.tar.gz

install() {
	sudo rm -i /usr/local/bin/lapce
	rm -rf $APP
	mkdir -p $APP
	cd $APP
	wget -O lapce.tar.gz $DOWNLOAD
	tar xvf lapce.tar.gz
	cd Lapce
	chmod +x lapce
	sudo ln -sr lapce /usr/local/bin/lapce
}

help() {
	echo "
install
"
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
