#!/bin/bash

config() {
	read -p "User name: " -r name
	read -p "User email: " -r email
	git config --global user.name "$name"
	git config --global user.email "$email"
	git config --list
}

createkey() {
	PSSH=~/.ssh
	read -p "Comment: " -r comment
	read -p "Agregar nombre de llave: " -r key
	rm -i PSSH/$key
	rm -i PSSH/$key.pub
	ssh-keygen -t rsa -b 4096 -C "$comment" -f $key
	mv $key $PSSH
	mv $key.pub $PSSH
	ssh-add $PSSH/$key
	cat $PSSH/$key.pub
}

help() {
	echo "
config
createkey
  "
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
