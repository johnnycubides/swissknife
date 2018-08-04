#!/bin/bash
# Instructions
# chmod +x bitacora.sh
# sudo cp bitacora.sh /usr/local/bin/
# bitacora.sh "command" "observation"
#Author: Johnny Cubides
#e-mail: jgcubidesc@gmail.com
#date: Thu Jun 21 11:39:03 -05 2018


# Permite guardar información acerca de comandos usados
if [ "$1" = "-h" ] || [ "$1" = "" ] || [ "$1" = "--help" ];
then
    printf "Help for this command bitacora.sh\n"
    printf "\tbitacora.sh \"command\" \"observation\"\n"
    printf "\tbitacora.sh [Options] \"command\" \"observation\"\n"
    printf "\t[Options]\n"
    printf "\t\t-t\tthis separator\\t\n\t\t-,\tthis separator , (this default)\n"
    printf "\tbitacora.sh [Parameters]\n"
    printf "\t[Parameters]\n"
    printf "\t\t-i\tstart bitacora.csv\n"
    printf "\t\t-v\tview content\n"
    printf "\t\t-sc\tview content in sc\n"
    printf "\t\t-h,--help\tHelp\n"
    printf "\nRegards Johnny.\n"
elif [ "$1" = "-sc" ];
then
    cat bitacora.csv | psc -L -k -d, | sc
elif [ "$1" = "-v" ];
then
    less bitacora.csv
elif [ "$1" = "-i" ];
then
    touch bitacora.csv && printf "`pwd`\ndate,command,observations\n" >> bitacora.csv
elif [ "$1" = "-t" ];
then
    #separator (\t)
    printf "`date`\t$2\t$3\n" >> bitacora.csv
    printf "Task successful `whoami`\n"
elif [ "$1" = "-," ];
then
    #separator (,)
    printf "`date`,$2,$3\n" >> bitacora.csv
    printf "Task successful `whoami`\n"
else
    printf "`date`,$1,$2\n" >> bitacora.csv
    printf "Task successful `whoami`\n"
fi
