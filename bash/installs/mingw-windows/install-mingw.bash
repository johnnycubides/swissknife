#!/bin/bash

install() {
	sudo apt install \
		mingw-w64 \
		wine32 \
		wine64 \
		-y
}

if [[ -v 1 ]]; then
	$1
fi
