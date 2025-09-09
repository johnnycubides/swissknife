#!/bin/bash

dependencies() {
	sudo apt install \
		fish \
		curl \
		-y
	mkdir -p $HOME/.config/fish/conf.d/
}

install() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

uninstall() {
	rustup self uninstall
}

info() {
	whereis rustc
	rustc -V
	whereis cargo
	cargo -V
	whereis rustup
	rustup -V
}

help() {
	echo "
install
info
uninstall
version
"
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
