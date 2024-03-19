#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Genera el enlace simbolico para sw
# Author: Johnny Cubids
# e-mail: jgcubidesc@unal.edu.co
# date: Wednesday 29 September 2021
status=$?

LOCAL_BIN=/usr/local/bin
BIN=sw.sh

install() {
	sudo ln -sr $BIN /usr/local/bin/$BIN
}

remove() {
	sudo rm -i $LOCAL_BIN/$BIN
}

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
