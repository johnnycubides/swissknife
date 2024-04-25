#!/bin/bash

PD=~/gitPackages
APP=$PD/nvim

dependencies() {
	sudo apt remove neovim
	sudo rm -rf /usr/local/bin/nvim
	sudo rm -rf /usr/local/share/nvim
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
	COMMIT="af8500af64571f787579b60bf0064cd05655fd51"
	cd $APP
	git checkout $COMMIT
	cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
	check
	cd build && cpack -G DEB
	check
}

install() {
	cd $APP/neovim/build/
	sudo dpkg -i nvim-linux64.deb
	check
}

update() {
	cd $APP/neovim
	git pull
	build
	echo "puede ahora dar la orden de instalar"
}

autoremove() {
	rm -rf $APP
}

check() {
	if [[ $? -ne 0 ]]; then
		exit $?
	fi
}

help() {
	echo "
dependencies
download
build
install
autoremove

Observación: Antes de realizar actualización modifique el commit,
como es el cason de mason y las funciones puede fallar.
  "
}

all() {
	dependencies
	download
	build
	install
	autoremove
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
