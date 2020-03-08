#!/bin/bash

if [ "$1" = "-h" ] || [ "$1" = "" ] || [ "$1" = "--help" ];
then
  printf "Help for this command asciinema-upload.sh\n"
  printf "\tasciinema-upload.sh Command options\n"
  printf "\t[Commands]\n"
  printf "\t\tdemo.cast\tsube un vídeo desarrollado con asccinema\n"
  printf "\t\t-h,--help\tHelp\n"
  printf "\nRegards Johnny.\n"
else
  curl -v -u $USER:$(cat ~/.config/asciinema/install-id) https://asciinema.org/api/asciicasts -F asciicast=@$1
fi

