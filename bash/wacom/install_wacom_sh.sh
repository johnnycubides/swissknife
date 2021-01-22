#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Instalación de wacom.sh Configuración para tableta digitalizadora
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date: Friday 22 January 2021
status=$?

if [ ! -L /usr/local/bin/wacom.sh ]; then
  sudo ln -sr wacom.sh /usr/local/bin/wacom.sh
  echo `ls -l /usr/local/bin/wacom.sh`" simbolic link created"
else
  echo `ls -l /usr/local/bin/wacom.sh`" simbolic link exist"
  read -p "Desea reescribir el enlace simbolico y/n: " -r temp
  if [ "$temp" = "y" ];
  then
    sudo rm -v /usr/local/bin/wacom.sh
    sudo ln -sr wacom.sh /usr/local/bin/wacom.sh
    echo `ls -l /usr/local/bin/wacom.sh`" simbolic link created"
  fi
fi
