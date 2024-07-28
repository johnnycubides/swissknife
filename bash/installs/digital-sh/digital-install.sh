#!/bin/bash

DP=~/gitPackages
DAPP=$DP/digital
LBIN=/usr/local/bin

update() {
	sudo apt update
}

dependencies() {
	sudo apt install \
		openjdk-11-jdk \
		-y
}

install() {
	sudo rm $LBIN/Digital.sh
	rm -rf $DAPP
	mkdir -p $DAPP
	cd $DAPP
	wget -O digital.zip https://github.com/hneemann/Digital/releases/latest/download/Digital.zip
	unzip digital.zip
	cd Digital
	./install.sh
	sudo ln -sr ./Digital.sh $LBIN/Digital.sh
	cd ..
	rm digital.zip
}

help() {
	echo "
update
dependencies
install
  "
}
if [[ -v 1 ]]; then
	$1
else
	help
fi
