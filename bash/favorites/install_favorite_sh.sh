#!/bin/bash -e
#
# Brief:	Instalación de favorites.sh
# Author: Johnny Cubides
# e-mail: johnnycubides@catalejoplus.com
# date: Wednesday 26 December 2018

SCRIPT=favorites.sh

if [ ! -L /usr/local/bin/$SCRIPT ]; then
  sudo ln -sr $SCRIPT /usr/local/bin/$SCRIPT
  echo `ls -l /usr/local/bin/$SCRIPT`" simbolic link created"
else
  echo `ls -l /usr/local/bin/$SCRIPT`" simbolic link exist"
  read -p "Desea reescribir el enlace simbolico y/n: " -r temp
  if [ "$temp" = "y" ];
  then
    sudo rm -v /usr/local/bin/$SCRIPT
    sudo ln -sr $SCRIPT /usr/local/bin/$SCRIPT
    echo `ls -l /usr/local/bin/$SCRIPT`" simbolic link created"
  fi
fi

if [[ ! -d ~/favoriteLinks ]]; then
  mkdir -p ~/favoriteLinks
fi

