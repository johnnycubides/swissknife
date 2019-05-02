#!/bin/bash -e
#
# Brief:	Instalación de Gradle desde el repositorio oficial
# Author: Johnny Cubides
# e-mail: <jgcubidesc@gmail.com> <johnnycubides@catalejoplus.com>
# date: Wednesday 01 May 2019

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

GRADLE_DOWNLOAD=gradle-5.4.1
GRADLE_ZIP=$GRADLE_DOWNLOAD-bin.zip
LINK_GRADLE_BIN=https://services.gradle.org/distributions/$GRADLE_ZIP

printf "${CYAN} A continuación va a instalar la versión de GRADLE: ${GREEN}${GRADLE_DOWNLOAD}${NC}\n"
printf "Si desea instalar otra versión, por favor cambie el valor de la variable GRADLE en éste script.\n\n"
printf "Si ya contaba con Gradle instalado desde un gestor de programas precompilados detenga éste script, remueva Gradle usando por ejemplo ${CYAN}sudo apt remove gradle${NC} si es usuario de apt y reinicie éste script.\n\n"

# FUNCTIONS
function install_gradle() {
  sudo rm -rf /opt/gradle
  sudo mkdir -p /opt/gradle
  sudo unzip -d /opt/gradle $GRADLE_ZIP
  printf "\nArchivos instalados de Gradle:\n"
  ls --color /opt/gradle/$GRADLE_DOWNLOAD
  printf "\nCreando enlace simbólico de Gradle:\n"
  if [[ -e /usr/local/bin/gradle ]]; then
    sudo rm -r /usr/local/bin/gradle
  fi
  sudo ln -sr /opt/gradle/$GRADLE_DOWNLOAD/bin/gradle /usr/local/bin/gradle
  printf "\n${GREEN}Instalación terminada!!!${NC}\n"
}

if [[ ! -e $GRADLE_ZIP ]]; then
  printf "${CYAN}Descargando Gradle de página oficial...${NC}\n"
  wget -O $GRADLE_ZIP "$LINK_GRADLE_BIN"
  install_gradle
else
  read -p "Existe una copia de éste gradle en su equipo, ${YELLOW}¿desea borrar ésta copia?${NC} Y/N: " -r TEMP
  if [ "$TEMP" = "y" ] || [ "$TEMP" = "Y" ];
  then
    rm -f $GRADLE_ZIP
    printf "${CYAN}Descargando Gradle de página oficial...${NC}\n"
    wget -O $GRADLE_ZIP "$LINK_GRADLE_BIN"
  fi
  install_gradle
fi

if [[ -e $GRADLE_ZIP ]]; then
  read -p "${YELLOW}¿Desea borrar la copia $GRADLE_ZIP descargada en su equipo?${NC} Y/N: " -r TEMP
  if [ "$TEMP" = "y" ] || [ "$TEMP" = "Y" ];
  then
    rm -f $GRADLE_ZIP
  else
    printf "${CYAN}La copia de Gradle $GRADLE_ZIP será conservada en su equipo.${NC}\n"
  fi
fi

printf "${GREEN}Saludos Johnny${NC}\n"

