#!/bin/bash

remove() {
	# Aún no lo he probado
	sudo dpkg --remove discord
}

install() {
	wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
	sudo dpkg -i discord.deb
	rm -f discord.deb
}

if [[ -v 1 ]]; then
	$1
fi
