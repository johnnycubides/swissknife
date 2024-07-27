#!/bin/bash

PD=~/gitPackages
APP=neovim
DIRAPP=$PD/$APP

update() {
	sudo apt update
}

dependencies() {
	sudo apt remove neovim
	sudo rm -rf /usr/local/bin/nvim
	sudo rm -rf /usr/local/share/nvim
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
	mkdir -p $PD
	cd $PD
	git clone git@github.com:neovim/neovim.git $APP
}

build() {
	# Docs: https://github.com/neovim/neovim/blob/master/BUILD.md
	#https://github.com/neovim/neovim/commit/27fb62988e922c2739035f477f93cc052a4fee1e
	COMMIT="af8500af64571f787579b60bf0064cd05655fd51"
	COMMIT="27fb62988e922c2739035f477f93cc052a4fee1e"
	cd $DIRAPP
	git checkout $COMMIT
	rm -rf build .dep # Para los procesos de rebuild activar esta línea
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	check
	cd build && cpack -G DEB
	check
}

install() {
	cd $DIRAPP/build/
	sudo dpkg -i nvim-linux64.deb
	check
}

nvim-git-update() {
	cd $DIRAPP
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
update
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
