#!/bin/bash
#sh snippets_send.sh
#Author: Johnny Cubides
#e-mail: jgcubidesc@gmail.com
#date: Fri Jun 22 18:17:43 -05 2018

dir=UltiSnips

printf "=======================\n"
printf "Snippets to send to vim\n"
printf "=======================\n"
printf "Select one option\n\n"
printf "\tc --> create directory UltiSnips\n"
printf "\t1 --> javascript.snippets\n"
printf "\n"

read -p "Select value: " select

case "$select" in
    "c")
        mkdir -p .vim/my-snippets/UltiSnips/
        ;;
    "1")
        cp $dir/javascript.snippets ~/.vim/my-snippets/UltiSnips/
        printf "Task sussesful `whoami`\n"
        ;;
    *)
        printf "Did not select valid option\n"
        ;;
esac

printf "Regards Johnny\n"
