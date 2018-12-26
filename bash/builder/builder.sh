#!/bin/bash -e
#
# Brief:	Carga algunos templates de mkdocs, sphinx, reactsjs para
#   hacer documentación.
# Author: Johnny Cubides
# e-mail: johnnycubides@catalejoplus.com
# date: Wednesday 26 December 2018

PATH_SWISSKNIFE=~/projects/swissknife/
PATH_MKDOCS=markdown/mkdocs/

# Permite guardar información acerca de comandos usados
if [ "$1" = "-h" ] || [ "$1" = "" ] || [ "$1" = "--help" ];
then
    printf "Help for this command builder.sh\n"
    printf "\tbuilder.sh Command options\n"
    printf "\t[Commands]\n"
    printf "\t\tmkdocs\tConstruir documentación con markdown y mkdocs\n"
    printf "\t\tlatex\tConstruir documentación con LaTeX\n"
    printf "\t\treveals\tConstruir presentaciones con reveals\n"
    printf "\t\t-h,--help\tHelp\n"
    printf "\nRegards Johnny.\n"
elif [ "$1" = "mkdocs" ];
then
  cp -rv $PATH_SWISSKNIFE$PATH_MKDOCS* ./
elif [ "$1" = "latex" ];
then
    echo "pass"
elif [ "$1" = "reveals" ];
then
    echo "pass"
fi

