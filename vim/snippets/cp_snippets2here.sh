##!/bin/bash
#sh snippets_send.sh
#Author: Johnny Cubides
#e-mail: jgcubidesc@gmail.com
# Sat Jun 23 18:25:55 -05 2018

read -p "you want to copy the existing snippets from ~/.vim/my-snippets/UltiSnips/ ? y/n " option
if [ "$option" = "y" ] || [ "$option" = "yes" ]; then
    cp ~/.vim/my-snippets/UltiSnips/* ./UltiSnips/
    printf "Task sussesful `whoami`\n"
else
    printf "the copy was not made\n"
fi

printf "Regards Johnny\n"
