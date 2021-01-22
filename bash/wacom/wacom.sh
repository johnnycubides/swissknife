#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Configuración para tableta digitalizadora
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date: Friday 22 January 2021
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

mapping(){
    OUTPUT=""
    # for get ID exec xsetwacom --list devices
    ID="11"
    if [ "$1" = "1" ];
    then
        OUTPUT="LVDS-1"
    elif [ "$1" = "2" ];
    then
        OUTPUT="HDMI-1"
    else
        printf " ${RED} No seleccionó una pantalla para configurar la \
tableta digitalizadora${NC}\n"
        return 0;
    fi
    xsetwacom --set 11 MapToOutput $OUTPUT
    if [[ $? == 0 ]]; then
        printf "${GREEN} Se ha configurado la tableta para escribir en ${OUTPUT}${NC}\n"
    fi
}

help(){
    printf "Help for this command wacom.sh\n"
    printf "\t wacom.sh <x> \t<x> -> es el número de la pantalla\n"
    printf "\twacom.sh Command options\n"
    printf "\t[Commands]\n"
    printf "\t\tcommand1\tbrief1\n"
    printf "\t\tcommand2\tbrief2\n"
    printf "\t\tcommand3\tbrief3\n"
    printf "\t\t-h,--help\tHelp\n"
    printf "\nRegards Johnny.\n"
}

# Permite guardar información acerca de comandos usados
if [ "$1" = "" ];
then
    printf "Del siguiente menú escoja la opción de salida para configurar la pantalla:
    1 -> LVDS-1
    2 -> HDMI-1
    h -> Ayuda\n"
    read -p "Seleccione una opción: " -r temp
    if [ "$temp" = "h" ] || [ "$temp" = "" ];
    then
        help
    else
        mapping $temp
    fi 
elif [ "$1" = "-h" ] || [ "$1" = "--help" ];
then
    help
elif [ "$1" = "1" ] || [ "$1" = "2" ] || [ "$1" = "3" ];
then
    mapping $1
elif [ "$1" = "command2" ];
then
    echo "pass"
elif [ "$1" = "command3" ];
then
    echo "pass"
else
    printf "${RED}Opción no establecida${NC}\n"
    help
fi


