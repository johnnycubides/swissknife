#!/bin/bash
#sh fileFormatConverter
#Author: Johnny Cubides
#e-mail: jgcubidesc@gmail.com
#Mon Jun 25 21:49:48 -05 2018

printf "=======================\n"
printf "File format converter  \n"
printf "=======================\n"


if [ "$1" = "-h" ] || [ "$1" = "" ] || [ "$1" = "--help" ];
then
    printf "Help for this command fileFormatConverter\n"
    printf "\t-l\tformat list\n"
    printf "\t-r\tread the format\n"
    printf "\t-c\tconvert format\n"
    printf "Example to use\n"
    printf "fileFormatConverter -c file_in file_out\n"
elif [ "$1" = "-l" ]
then
    iconv -l
elif [ "$1" = "-r" ]
then
    file -i $2
elif [ "$1" = "-c" ]
then
    format_in=`file --mime-encoding -b $2`
    printf "Format input file: $format_in\n"
    printf "Select format output\n"
    printf "\t1 --> ISO-8859-1\n"
    printf "\t2 --> UTF-8\n\n"
    read -p "Select value: " select
    case "$select" in
        "1")
            format_out="ISO-8859-1"
            ;;
        "2")
            format_out="UTF-8"
            ;;
        *)
            format_out=""
            ;;
    esac
    if [ "$format_out" != "" ]
    then
        if [ "$3" = "" ]
        then
            iconv -f $format_in -t $format_out $2 -o $2
        else
            iconv -f $format_in -t $format_out $2 -o $3
        fi
        printf "Task sussesful `whoami`\n"
    fi
else
    printf "Did not select valid option\n"
fi

printf "Regards Johnny\n"
