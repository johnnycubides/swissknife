#!/bin/bash

APP=zathura
DAPP=~/gitPackages/$APP
VERSION=0.5.5
DOWNLOAD=https://github.com/pwmt/zathura/archive/refs/tags/$VERSION.tar.gz

dependencies() {
	sudo apt update
	sudo apt install \
		fish \
		libgtk-3-dev \
		libglib2.0-dev \
		libgirara-gtk3-3 \
		libmagic-dev \
		libjson-glib-dev \
		libsqlite3-dev \
		libsynctex-dev \
		libseccomp-dev \
		meson \
		gettext \
		pkgconf \
		check \
		librsvg2-bin \
		sphinx \
		doxygen \
		python3-breathe \
		sphinx-rtd-theme-common \
		-y
}

download() {
	mkdir -p $DAPP
	cd $DAPP
	wget -O zathura.tar.gz $DOWNLOAD
	tar xvf zathura.tar.gz
}

build() {
	cd $DAPP/zathura-$VERSION
	meson setup --reconfigure --libdir=/usr/local/lib/x86_64-linux-gnu/ build
	cd build
	ninja
}

install() {
	cd $DAPP/zathura-$VERSION/build
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
