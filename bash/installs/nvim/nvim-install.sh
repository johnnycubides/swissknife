#!/bin/bash

PD=~/gitPackages
APP=$PD/nvim

dependencies() {
	sudo apt update
	sudo apt install \
		make \
		cmake \
		gettext \
		python3-pynvim \
		-y
	sudo apt autoremove
	npm install -g neovim
}

download() {
	mkdir -p $APP
	cd $APP
	git clone https://github.com/neovim/neovim
}

build() {
	# Docs: https://github.com/neovim/neovim/blob/master/BUILD.md
	cd $APP
	cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
	cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
}

autoremove() {
	rm -rf $APP
}

dependencies
download
build
autoremove
