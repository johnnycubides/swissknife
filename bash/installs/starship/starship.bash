#!/bin/bash

install() {
  curl -sS https://starship.rs/install.sh | sh
}

bashrc() {
  echo 'eval "$(starship init bash)"' >>~/.bashrc
}

config() {
  mkdir -p ~/.config && cp ./starship.toml ~/.config/
}

help() {
  echo "install # instalar plugin desde crates
bashrc # Agregar al bashrc una ÚNICA VEZ la configuración
config # Agregar configuraci+on personalizada
help"
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
