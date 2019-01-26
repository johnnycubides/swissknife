#!/bin/bash -e
#
# Brief:	Carga algunos templates de mkdocs, sphinx, reveal para
#   hacer documentación.
# Author: Johnny Cubides
# e-mail: johnnycubides@catalejoplus.com
# date: Wednesday 26 December 2018

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

PATH_SWISSKNIFE=~/projects/swissknife
PATH_MKDOCS=markdown/mkdocs
PATH_REVEAL=~/gitPackages/reveal.js

# Init Reveal
init_revealjs(){
  # Solicitando nombre para presentación
  read -p "${MAGENTAB}--${NCB} ${CYAN}Nombre de la presentación${NC}\
 (un solo nombre, ejemplo: un-solo-nombre): " -r name_pres

  # sustituyendo caracteres inválidos
  name_pres=${name_pres//[ *#?]/-}
  echo $name_pres
  # Comprobación de nombre para presentación ingresado y solicitud de demás parámetros
  if [ "$name_pres" != "" ];
  then

    # Solicitando el directorio de almacenamiento de la presentación
    echo -e "${MAGENTAB}--${NCB} ${CYAN}Nombre del directorio que contendrá la presentación${NC}\
 (un solo nombre),\n si desea que sea ${CYAN}el mismo nombre de la presentación oprima${NC}\
 ${YELLOW}ENTER${NC},\n sino desea crear ese directorio digite la palabra ${BLUE}none${WHITE}: "
    read -p "Respuesta del usuario: " -r dir_pres

    # sustituyendo caracteres inválidos
    dir_pres=${dir_pres//[ *#?]/-}

    # Portable o no portable la presentación
    read -p "${MAGENTAB}--${NCB} ${CYAN}¿Requiere hacer la presentación portable?${NC}\
 ${GREEN}y${NC}/${RED}n${NC}: " -r port_pres

    # Creación de esqueleto para la presentación?
    read -p "${MAGENTAB}--${NCB} ${CYAN}¿Desea un esqueleto para la presentación?${NC}\
 ${GREEN}y${NC}/${RED}n${NC}: " -r tem_pres

    # Definición de creación de directorio contendor de la presentación
    if [ "$dir_pres" = "none" ]; # no se creará directorio contenedor
    then
      dir_pres=.
    elif [ "$dir_pres" != "" ];  # se creará directorio con el nombre dado por el usuario
    then
      dir_pres=./$dir_pres
    else                        # se creará el directorio con el mismo nombre de la presentación
      dir_pres=./$name_pres
    fi

    # creación de directorios video, imagenes, audio
    mkdir -pv $dir_pres/img $dir_pres/videos $dir_pres/audios

    # Definición si la presentación es portable o no.
    if [ "$port_pres" = "y" ];
    then
      mkdir -p $dir_pres/reveal.js
      cp -rv $PATH_REVEAL/css $dir_pres/reveal.js/css
      cp -rv $PATH_REVEAL/js $dir_pres/reveal.js/js
      cp -rv $PATH_REVEAL/lib $dir_pres/reveal.js/lib
      cp -rv $PATH_REVEAL/plugin $dir_pres/reveal.js/plugin
    else
      if [ ! -L $dir_pres/reveal.js ]; then
        ln -srv $PATH_REVEAL $dir_pres/reveal.js
      else
        echo `ls -l reveal.js`" simbolic link exist"
      fi
    fi

    # generar esqueleto para presentación?
    if [ "$tem_pres" = "y" ];
    then
      cp -v $PATH_SWISSKNIFE/html/revealjs/template.html $dir_pres/$name_pres.html
    else
      touch $dir_pres/$name_pres.html
    fi

    echo -e "${GREEN}Task done!!! \nSaludos Johnny${NC}"

  else
    echo " ${REDB}Interrupt!!! Debe darle un nombre a la presentación, END.${NCB}"
  fi
}

#init mkdocs
init_mkdocs(){
  # Solicitando el directorio de almacenamiento de la presentación
  echo -e "${MAGENTAB}--${NCB} ${CYAN}Nombre del directorio que contendrá la documentación${NC}\
 (un solo nombre),\n sino desea crear ese directorio oprima ${YELLOW}ENTER${NC}: "
  read -p "Respuesta del usuario: " -r dir_pres
  # sustituyendo caracteres inválidos
  dir_pres=${dir_pres//[ *#?]/-}
  if [ "$dir_pres" != "" ];  # se creará directorio con el nombre dado por el usuario
  then
    dir_pres=./$dir_pres
    mkdir -pv $dir_pres
  else                        # se creará la documentación en el directorio actual
    dir_pres=.
  fi
  cp -rv $PATH_SWISSKNIFE/$PATH_MKDOCS/* $dir_pres/
  rm -f $dir_pres/INSTALL.md
  echo -e "${GREEN}Task done!!! \nSaludos Johnny${NC}"
}

# Permite guardar información acerca de comandos usados
if [ "$1" = "-h" ] || [ "$1" = "" ] || [ "$1" = "--help" ];
then
    printf "Help for this command builder.sh\n"
    printf "\t${CYAN}builder.sh${NC} Command options\n"
    printf "\t[Commands]\n"
    printf "\t\t${CYAN}mkdocs${NC}\tConstruir documentación con markdown y mkdocs\n"
    printf "\t\tlatex\tConstruir documentación con LaTeX\n"
    printf "\t\t${CYAN}reveal${NC}\tConstruir presentaciones con reveal\n"
    printf "\t\t-h,--help\tHelp\n"
    printf "\n${GREEN}Regards Johnny.${NC}\n"
elif [ "$1" = "mkdocs" ];
then
  init_mkdocs
elif [ "$1" = "latex" ];
then
    echo "pass"
elif [ "$1" = "reveal" ];
then
    init_revealjs
fi

