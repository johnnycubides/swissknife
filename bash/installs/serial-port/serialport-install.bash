#!/bin/bash

install() {
	sudo apt update
	sudo apt install \
		picocom \
		minicom \
		-y
}

help() {
	echo "
install
  "
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
