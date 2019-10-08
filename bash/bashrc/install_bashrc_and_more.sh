#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Instalador tanto de bashrc como alias y ...
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date: Thursday 26 September 2019
status=$?

echo "Instalación del bashrc"
if [[ -e ~/.bashrc ]]; then
  mv ~/.bashrc ~/.bashrc_old
fi
ln -s `pwd`/bashrc ~/.bashrc

echo "Instalación de reglas para alias"
if [[ -e ~/.bash_aliases ]]; then
  mv ~/.bash_aliases ~/.bash_aliases_old
fi
ln -s `pwd`/bash_aliases ~/.bash_aliases

echo "Asignación de colores para ls"
if [[ -e ~/.dicolors ]]; then
  mv ~/.dicolors ~/.dicolors_old
fi
ln -s `pwd`/dircolors ~/.dircolors
