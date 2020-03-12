#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Script de instalación de arduino-cli
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date: jueves 12 marzo 2020
status=$?

DESTINATION=~/gitPackage/bin

mkdir -p $DESTINATION
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=$DESTINATION sh
sudo ln -sr $DESTINATION/arduino-cli /usr/local/bin
arduino-cli config init
arduino-cli core update-index
arduino-cli core install arduino:avr

