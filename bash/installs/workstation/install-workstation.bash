#!/bin/bash

LOCAL_BIN=/usr/local/bin
BIN_NAME=workstation.sh

install() {
	sudo ln -sr ./$BIN_NAME $LOCAL_BIN
}

remove() {
	sudo rm -i $LOCAL_BIN/$BIN_NAME
}

# install
# remove

help() {
	echo "Arguments:"
	echo "install"
	echo "remove"
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
