#!/bin/bash

# apt-add() {
# 	sudo add-apt-repository ppa:kicad/kicad-8.0-releases
# }

update() {
	sudo apt update
}

install() {
	sudo apt install \
		kicad \
		kicad-packages3d \
		-y
}

# apt-add
install
