#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Configuración para tableta digitalizadora
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date: Friday 22 January 2021
status=$?

# foreground
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
NC=$(tput setaf 7)
# background
BLACKB=$(tput setab 0)
REDB=$(tput setab 1)
GREENB=$(tput setab 2)
YELLOWB=$(tput setab 3)
BLUEB=$(tput setab 4)
MAGENTAB=$(tput setab 5)
CYANB=$(tput setab 6)
WHITEB=$(tput setab 7)
NCB=$(tput setab 0)

MONITORS='' #Lista de monitores

# El siguiente código es tomado y adapatdo de
# https://stackoverflow.com/questions/10500521/linux-retrieve-monitor-names
get_monitors() {
  while read -r output hex conn; do
    [[ -z "$conn" ]] && conn=${output%%-*}
    MONITORS="$MONITORS$output "
    # echo "$output" >> $DIR/monitors
  done < <(
    xrandr --prop | awk '
        !/^[ \t]/ {
            if (output && hex) print output, conn
            output=$1
            hex=""
        }
        /ConnectorType:/ {conn=$2}
        /[:.]/ && h {
            sub(/.*000000fc00/, "", hex)
            hex = substr(hex, 0, 26) "0a"
            sub(/0a.*/, "", hex)
            h=0
        }
        h {sub(/[ \t]+/, ""); hex = hex $0}
        /EDID.*:/ {h=1}
        END {if (output && hex) print output, conn}
        ' | sort
  )
}

select_monitor() {
  # TMP=$(xrandr --listmonitors)
  # mkdir -p /tmp/wacom
  # xrandr --listmonitors >> /tmp/wacom/monitors
  # $TMP=`cat /tmp/wacom/monitors`

  # TMP=$(cat $DIR/monitors | tr '\n' ' ')

  # TMP="$TMP"
  # TMP="${TMP//'\r'/=}"
  # TMP=${TMP//+/_}
  # readarray -d + -t starray <<< "$TMP"
  # IFS=$'\n'
  IFS=' '

  read -a strarr <<<"$MONITORS"

  printf "Este script le ayudará a detectar una pantalla para configurar la escritura con su tableta digitalizadora.\n"
  printf "Por favor  conecte el dispositivo al puerto USB para iniciar procedimiento.\n"
  printf "Del siguiente menú escoja la opción de salida para configurar la pantalla:\n"
  # Print each value of the array by using loop
  for ((n = 0; n < ${#strarr[*]}; n++)); do
    echo "      $n -> ${strarr[n]}"
  done
  read -p "Seleccione una opción: " -r temp
  mapping ${strarr[temp]}
}

mapping() {
  OUTPUT=$1
  # for get ID exec xsetwacom --list devices
  #ID="11"
  # DEVICENAME="HUION Huion Tablet_HS64 stylus"
  # DEVICENAME="HUION Huion Tablet_HS64 Pen stylus"
  DEVICENAME="HUION Huion Tablet_HS64 Stylus stylus"

  xsetwacom --set "$DEVICENAME" MapToOutput $OUTPUT
  if [[ $? == 0 ]]; then
    printf "${GREEN} Se ha configurado la tableta para escribir en ${OUTPUT}${NC}\n"
  else
    printf "${RED} No fue posible configurar la tableta digitalizadora${NC}\n"
  fi
}

help() {
  printf "Help for this command wacom.sh\n"
  printf "\t wacom.sh <x> \t<x> -> es el número de la pantalla\n"
  printf "\twacom.sh Command options\n"
  printf "\t[Commands]\n"
  printf "\t\tlist\tlistar dispositivos de entrada\n"
  printf "\t\tcommand2\tbrief2\n"
  printf "\t\tcommand3\tbrief3\n"
  printf "\t\t-h,--help\tHelp\n"
  printf "\nRegards Johnny.\n"
}

get_monitors
# echo $MONITORS
select_monitor
printf "\nRegards Johnny.\n"
