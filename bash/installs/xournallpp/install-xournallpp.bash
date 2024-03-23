#!/bin/bash

APP=xournalpp
DOWNLOAD=https://github.com/xournalpp/xournalpp/releases/download/v1.2.3/xournalpp-1.2.3-Debian-bullseye-x86_64.deb

dependencies() {
	sudo apt update
	sudo apt install \
		libportaudio2 libportaudiocpp0 libzip4 \
		-y
}

install() {
	wget -O $APP.deb $DOWNLOAD
	sudo dpkg -i $APP.deb
	rm -f $APP.deb
}

help() {
	echo "
dependencies
install
  "
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
