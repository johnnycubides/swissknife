#!/bin/bash

APP=ctags
DPACK=~/gitPackages
GIT="https://github.com/universal-ctags/ctags.git"

dependecies() {
	sudo apt install \
		automake \
		-y
}

update() {
	sudo apt update
	dependecies
}

download() {
	cd $DPACK
	rm -rf $APP
	git clone $GIT $APP
}

install() {
	cd $DPACK/$APP
	./autogen.sh
	./configure
	make
	sudo make install
}

remove() {
	cd $DPACK && rm -rf $APP
}

help() {
	echo "
update
dependecies
install
remove
"
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
