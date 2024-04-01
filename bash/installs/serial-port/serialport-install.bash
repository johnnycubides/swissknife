#!/bin/bash

update() {
	sudo apt update
	install
}

install() {
	sudo apt install \
		picocom \
		minicom \
		-y
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
