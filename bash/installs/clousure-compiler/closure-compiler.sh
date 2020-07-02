#!/bin/bash -e
#
# Brief:	Instalador de closure-compiler
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com, johnnycubides@catalejoplus.com
# date: Sunday 03 February 2019

# foreground
BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`
NC=`tput setaf 7`
# background
BLACKB=`tput setab 0`
REDB=`tput setab 1`
GREENB=`tput setab 2`
YELLOWB=`tput setab 3`
BLUEB=`tput setab 4`
MAGENTAB=`tput setab 5`
CYANB=`tput setab 6`
WHITEB=`tput setab 7`
NCB=`tput setab 0`

PATH_CLOSURE=~/gitPackages/closure-compiler

install_closure(){
  printf "${CYANB}--${NCB}Ahora comensará la instalación...\n"
  mkdir -p $PATH_CLOSURE
  wget -O compiler.zip  "https://dl.google.com/closure-compiler/compiler-latest.zip"
  unzip compiler -d $PATH_CLOSURE/
  temp=`ls $PATH_CLOSURE/closure-compiler*`
  echo
  mv $temp $PATH_CLOSURE/closure-compiler.jar
  chmod +x $PATH_CLOSURE/closure-compiler.jar
  echo "${CYAN}Dar permisos de SUPERUSUARIO para instalar enlace simbólico del compilador${NC}"
  sudo ln -sr $PATH_CLOSURE/closure-compiler.jar /usr/local/bin/
  echo "Verificaque a continuación que el compilador haya sido instalado correctamente."
  closure-compiler.jar --version
  read -p "Desea borrar la copia del compilador descargada? ${GREEN}y${NC}/${RED}n${NC}: " -r temp
  if [ "$temp" = "y" ];
  then
    rm -fv compiler.zip
    echo " ${MAGENTA}copia del compilador borrada${NC}"
  else
    echo " ${CYAN}Se mantiene la copia de compilador${NC}"
  fi
}

printf " ${YELLOWB}--${NCB} Instalación de ${CYAN}closure-compiler${NC}\n"

if [ ! -L /usr/local/bin/closure-compiler.jar ]; then
  if [[ ! -e $PATH_CLOSURE/closure-compiler.jar ]]; then
    install_closure
    echo "Regards Johnny"
  else
    echo "El compilador ya estaba instalado, se creará el enlace simbólico"
    sudo ln -sr $PATH_CLOSURE/closure-compiler.jar /usr/local/bin/
    closure-compiler.jar --version
    echo "Regards Johnny"
  fi
else
  echo `ls -l /usr/local/bin/closure-compiler.jar`" simbolic link exist"
  closure-compiler.jar --version
  read -p "¿Desea instalar otra copia o actualización de clousure-compiler.jar? ${GREEN}y${NC}/${RED}n${NC}: " -r tmp
  if [ "$tmp" = "y" ];
  then
    sudo rm /usr/local/bin/closure-compiler.jar
    rm -rf $PATH_CLOSURE/*
    install_closure
  fi
  echo "Regards Johnny"
fi

