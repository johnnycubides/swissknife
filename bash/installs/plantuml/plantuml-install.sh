#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Script para la descarga de plantuml.jar
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date: Saturday 11 April 2020
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

LINK_REPO=https://sourceforge.net/projects/plantuml/files/latest/download
PATH_DEST=~/gitPackages/plantuml
APP=plantuml.jar
APP_ZIP=plantuml.zip
PATH_JAVA=/usr/bin/java
PATH_TMP=/tmp

if [[ ! -d $PATH_DEST ]]; then
  printf "${YELLOW}Creando directorio destino\n${NC}"
  mkdir -p $PATH_DEST
fi

if [[ ! -e $PATH_DEST/$APP ]]; then
  printf "${YELLOW}Descargando la última versión de $APP\n${NC}"
  wget -O $PATH_TMP/$APP_ZIP "$LINK_REPO"
  printf "${YELLOW}Se ha descargado $APP_ZIP\n${NC}"
  printf "${YELLOW}A continuación se verificará el funcionamiento del paquete instalado\n${NC}"
  unzip -t $PATH_TMP/$APP_ZIP
  if [ $? == 0 ];
  then
    echo -e "A\n" | unzip $PATH_TMP/$APP_ZIP -d $PATH_DEST/
    $PATH_JAVA -jar $PATH_DEST/$APP -v
  else
    printf "${RED} $APP_ZIP no pudo ser comprobado\n"
  fi 
else
  read -p "${CYAN}Ya existe una version de $APP desea sustituirla?: y/n ${NC}" -r variable
  if [ "$variable" = "y" ];
  then
    printf "${YELLOW}renombrando versión antigua de $APP\n${NC}"
    mv $PATH_DEST/$APP $PATH_DEST/$APP.old
    printf "${YELLOW}Descargando la última versión de $APP\n${NC}"
    wget -O $PATH_TMP/$APP_ZIP "$LINK_REPO"
    printf "${YELLOW}Se ha descargado $APP_ZIP\n${NC}"
    printf "${YELLOW}A continuación se verificará el funcionamiento del paquete instalado\n${NC}"
    unzip -t $PATH_TMP/$APP_ZIP
    if [ $? == 0 ];
    then
      echo -e "A\n" | unzip $PATH_TMP/$APP_ZIP -d $PATH_DEST/
      $PATH_JAVA -jar $PATH_DEST/$APP -v
      read -p "${CYAN}¿Desea borrar la versión anterior? y/n: ${NC}" -r variable
      if [ "$variable" = "y" ];
      then
        printf "${YELLOW}Borrando la versión anterior\n${NC}"
        rm -f $PATH_DEST/$APP.old
      fi
    else
      printf "${RED} $APP_ZIP no pudo ser comprobado\n"
    fi
  fi 
fi

