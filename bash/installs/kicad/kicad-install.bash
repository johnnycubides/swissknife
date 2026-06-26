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

kicad-x11-ln() {
  LN=kicad-x11
  sudo rm -rf /usr/local/bin/$LN
  sudo ln -sr ./kicad-x11.bash /usr/local/bin/$LN
}

# apt-add
install
kicad-x11-ln
