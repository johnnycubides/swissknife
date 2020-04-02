#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Creador de enlaces simbólicos para directorios favoritos, una especie de MarkBooks.
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date: Monday 24 February 2020
status=$?

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

FAVORITE_DIR=~/favoriteLinks

createMarkbook(){
  FILE_NAME=$1
  DESTINATION=$2
  echo $DESTINATION
  echo $FILE_NAME

  if [[ ! -d $FAVORITE_DIR/$DESTINATION ]]; then
    mkdir -p $FAVORITE_DIR/$DESTINATION
  fi
  
  ln -P -v $PWD/$FILE_NAME $FAVORITE_DIR/$DESTINATION/$FILE_NAME
}

# Permite guardar información acerca de comandos usados
if [ "$1" = "-h" ] || [ "$1" = "" ] || [ "$1" = "--help" ];
then
  printf "Help for this command favorites.sh\n"
  printf "\tfavorites.sh Command options\n"
  printf "\t[Commands]\n"
  printf "\t\t-c <file> <subMenu>\tcreate markbook\n"
  printf "\t\t-o\topen markbook\n"
  printf "\t\t-d\tdelete markbook\n"
  printf "\t\t-h,--help\tHelp\n"
  printf "\nRegards Johnny.\n"
elif [ "$1" = "-c" ];
then
  createMarkbook $2 $3
elif [ "$1" = "-o" ];
then
  echo "pass"
elif [ "$1" = "-d" ];
then
  echo "pass"
fi
