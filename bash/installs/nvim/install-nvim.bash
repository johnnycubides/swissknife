#!/bin/bash

PD=~/gitPackages
APP=$PD/nvim

dependencies() {
  sudo apt remove neovim
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
  check
	cd build && cpack -G DEB
  check
}

install(){
  cd $APP/neovim/build/
  sudo dpkg -i nvim-linux64.deb
  check
}

autoremove() {
	rm -rf $APP
}

check(){
  if [[ $? -ne 0 ]] ; then
    exit $?
  fi
}

all() {
	dependencies
	download
	build
	autoremove
}

if [[ -v 1 ]]; then
	$1
fi
