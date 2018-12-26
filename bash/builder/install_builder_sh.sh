#!/bin/bash -e
#
# Brief:	Instalación de builder.sh
# Author: Johnny Cubides
# e-mail: johnnycubides@catalejoplus.com
# date: Wednesday 26 December 2018

if [ ! -L /usr/local/bin/builder.sh ]; then
  sudo ln -sr builder.sh /usr/local/bin/builder.sh
  echo `ls -l /usr/local/bin/builder.sh`" simbolic link created"
else
  echo `ls -l /usr/local/bin/builder.sh`" simbolic link exist"
  read -p "Desea reescribir el enlace simbolico y/n: " -r temp
  if [ "$temp" = "y" ];
  then
    sudo rm -v /usr/local/bin/builder.sh
    sudo ln -sr builder.sh /usr/local/bin/builder.sh
    echo `ls -l /usr/local/bin/builder.sh`" simbolic link created"
  fi
fi
