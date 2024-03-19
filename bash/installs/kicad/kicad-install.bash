#!/bin/bash

# apt-add() {
# 	sudo add-apt-repository ppa:kicad/kicad-8.0-releases
# }

install() {
	sudo apt update
	sudo apt install \
		kicad \
		kicad-packages3d \
		-y
}

# apt-add
install
