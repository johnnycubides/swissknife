#!/bin/bash

# Repositorio: https://github.com/plantuml/plantuml/releases
LBIN=/usr/local/bin
APP=plantuml
DAPP=~/gitPackages/$APP
VERSION=1.2024.3
DOWNLOAD=https://github.com/plantuml/plantuml/releases/download/v1.2024.3/plantuml-$VERSION.jar

dependencies() {
	sudo apt install \
		graphviz \
		-y
}

install() {
	rm -rf $DAPP
	sudo rm -i $LBIN/$APP
	mkdir -p $DAPP
	cp plantuml.bash $DAPP
	cd $DAPP
	wget -O plantuml.jar $DOWNLOAD
	sudo ln -sr plantuml.bash /usr/local/bin/$APP
}

if [[ -v 1 ]]; then
	$1
fi
