#!/bin/bash -e
#
# Brief:  Configuración interactiva para tableta digitalizadora
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date:   Friday 22 January 2021
#

# =======================
# Colores
# =======================
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
NC=$(tput sgr0)

# =======================
# Variables globales
# =======================
MONITORS=""
DEVICES=()
DEVICE_SELECTED=""
OUTPUT_SELECTED=""

# =======================
# Obtener monitores
# =======================
# Código adaptado de:
# https://stackoverflow.com/questions/10500521/linux-retrieve-monitor-names
get_monitors() {
  while read -r output hex conn; do
    [[ -z "$conn" ]] && conn=${output%%-*}
    MONITORS="$MONITORS$output "
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

# =======================
# Obtener dispositivos Wacom
# =======================
get_devices() {
  while IFS= read -r line; do
    # DEVICES+=("$(echo "$line" | sed 's/ id:.*//')")
    DEVICES+=(
      "$(echo "$line" |
        awk -F'\t' '{print $1}' |
        sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    )
  done < <(xsetwacom --list devices)
}

# =======================
# Seleccionar dispositivo
# =======================
select_device() {
  printf "\n${CYAN}Seleccione el dispositivo de entrada (tableta):${NC}\n"

  for ((i = 0; i < ${#DEVICES[@]}; i++)); do
    echo "      $i -> ${DEVICES[$i]}"
  done

  read -p "Seleccione una opción: " -r DEV_INDEX
  DEVICE_SELECTED="${DEVICES[$DEV_INDEX]}"

  if [[ -z "$DEVICE_SELECTED" ]]; then
    printf "${RED}Dispositivo inválido${NC}\n"
    exit 1
  fi
}

# =======================
# Seleccionar monitor
# =======================
select_monitor() {
  IFS=' '
  read -a strarr <<<"$MONITORS"

  printf "\n${CYAN}Seleccione el monitor de salida:${NC}\n"

  for ((n = 0; n < ${#strarr[@]}; n++)); do
    echo "      $n -> ${strarr[$n]}"
  done

  read -p "Seleccione una opción: " -r MON_INDEX
  OUTPUT_SELECTED="${strarr[$MON_INDEX]}"

  if [[ -z "$OUTPUT_SELECTED" ]]; then
    printf "${RED}Monitor inválido${NC}\n"
    exit 1
  fi
}

# =======================
# Mapear dispositivo a monitor
# =======================
mapping() {
  xsetwacom --set "$DEVICE_SELECTED" MapToOutput "$OUTPUT_SELECTED"
  if [[ $? == 0 ]]; then
    printf "\n${GREEN}Configuración exitosa:${NC}\n"
    printf "  Device : %s\n" "$DEVICE_SELECTED"
    printf "  Output : %s\n" "$OUTPUT_SELECTED"
  else
    printf "${RED}No fue posible configurar la tableta digitalizadora${NC}\n"
  fi
}

# =======================
# Flujo principal
# =======================
printf "${YELLOW}Configurador de tableta digitalizadora${NC}\n"

get_devices
get_monitors

select_device
select_monitor
mapping

printf "\nRegards Johnny.\n"
