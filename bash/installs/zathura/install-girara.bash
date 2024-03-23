#!/bin/bash

APP=girara
DAPP=~/gitPackages/$APP
VERSION=0.4.3
DOWNLOAD=https://github.com/pwmt/girara/archive/refs/tags/$VERSION.tar.gz

dependencies() {
	sudo apt update
	sudo apt remove libgirara-gtk3-3 -y # remover librerias globales
	sudo apt install \
		libgtk-3-dev \
		libglib2.0-dev \
		libjson-glib-1.0-common \
		meson \
		gettext \
		pkgconf \
		check \
		doxygen \
		-y
	# sphinx-rtd-theme-common \
	# libjson-glib-dev \
}

download() {
	mkdir -p $DAPP
	cd $DAPP
	wget -O $APP.tar.gz $DOWNLOAD
	tar xvf $APP.tar.gz
}

build() {
	cd $DAPP/$APP-$VERSION
	meson setup --reconfigure build
	cd build
	ninja
}

install() {
	cd $DAPP/$APP-$VERSION/build
	sudo ninja install
}

remove() {
	rm -rf $DAPP
}

all() {
	dependencies
	download
	build
	install
	remove
}

help() {
	echo "
dependencies
download
build
install
remove
  "
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
