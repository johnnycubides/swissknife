#!/bin/bash

update() {
	sudo apt update
}

install() {
	sudo apt install gnote
}

help() {
	echo "
update
install
  "
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
