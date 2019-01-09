#!/bin/bash -e
#
# Brief:	Instalador de script bitacora.sh
# Author: Johnny Cubides
# e-mail: johnnycubides@catalejoplus.com
# date: Wednesday 26 December 2018

if [ ! -L /usr/local/bin/bitacora.sh ]; then
  sudo ln -sr bitacora.sh /usr/local/bin/bitacora.sh
else
  echo `ls -l /usr/local/bin/bitacora.sh`" simbolic link exist"
  read -p "¿Desea sobreescribir el enlace a bitacora.sh? y/n: " -r temp
  if [ "$temp" = "y" ];
  then
    sudo rm -v /usr/local/bin/bitacora.sh
    sudo ln -sr bitacora.sh /usr/local/bin/bitacora.sh
    echo `ls -l /usr/local/bin/bitacora.sh`" simbolic link created"
  fi
fi
