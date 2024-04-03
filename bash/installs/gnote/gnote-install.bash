#!/bin/bash

update() {
	sudo apt update
}

install() {
	sudo apt install gnote
}

DATA=my-gnote
DDATA=~/gitPackages

config() {
	rm -ir $DDATA/$DATA
	mkdir -p $DDATA
	cd $DDATA
	git clone git@gitlab.com:johnnycubides/my-gnote.git $DATA
}

help() {
	echo "
update
install
config
  "
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
