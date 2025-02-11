#!/bin/bash

VERSION=v2.1.5

DOWNLOAD=https://github.com/lite-xl/lite-xl/releases/download/$VERSION/lite-xl-$VERSION-addons-linux-x86_64-portable.tar.gz

DP=~/gitPackages
DAPP=$DP/lite-xl
LOCAL_BIN=/usr/local/bin
SCRIPT_PATH=$(pwd)

# Remover enlace simbólico de lite-xl
removelocalbin() {
  sudo rm $LOCAL_BIN/lite-xl
}

# Remover lite-xl y su configuración
remove() {
  rm -rf $DAPP
  rm -rf $HOME/.config/lite-xl
  removelocalbin
  sync
}

# Instalación de dependencias
dependencies() {
  sudo apt update
  sudo apt install \
    gcc \
    -y
}

# Instalación de lite-xl portable
install() {
  # sudo ln -i $LOCAL_BIN/lite-xl
  rm -rf $DAPP
  mkdir -p $DAPP
  cd $DAPP
  wget -O lite-xl.tar.gz $DOWNLOAD
  check
  tar xvf lite-xl.tar.gz
  check
  rm lite-xl.tar.gz
  cd lite-xl
  sudo ln -sr ./lite-xl $LOCAL_BIN/lite-xl
  check
  read -p "==> ATENCIÓN: A continuación se lanzará el editor de Lite-XL, esto preparará la configuración de plugins, CIÉRRELO y permita que contienúe el proceso de instalación sin cerrar esta terminal. Para continuar oprima ENTER" -r variable
  echo "==> ATENCIÓN: AÚN NO HA TERMINADO EL PROCESO DE INSTLACIÓN"
  echo "==> CIERRE LA APLICACIÓN LITE-XL QUE SE ACABÓ DE ABRIR Y"
  echo "==> PERMITA QUE CONTINUE EL PROCESO DE INSTALACIÓN DE LOS PLUGINS DE LITE-XL EN ESTA TERMINAL"
  lite-xl # lanzar una prueba de lite-xl
  echo "lite-xl cerrado"
}

# Instalación del lsp plugin
lsp-install() {
  # https://github.com/lite-xl/lite-xl-lsp
  cd $HOME/.config/lite-xl/
  git clone https://github.com/lite-xl/lite-xl-lsp plugins/lsp
  git clone https://github.com/lite-xl/lite-xl-widgets libraries/widget
  git clone https://github.com/liquidev/lintplus plugins/lintplus
  wget https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/snippets.lua \
    -O plugins/snippets.lua
  wget https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/lsp_snippets.lua \
    -O plugins/lsp_snippets.lua
  check
}

# build plugin
build-install() {
  cd $DP
  git clone https://github.com/adamharrison/lite-xl-ide.git
  cp -R lite-xl-ide/plugins ~/.config/lite-xl/
  rm -rf lite-xl-ide
}

CONFIG_LITE_XL=~/.config/lite-xl
PLUG_LITE_XL=$CONFIG_LITE_XL/plugins

# Agregar la configuración aquí propuesta
# agregar verilog sintax
config() {
  cd $SCRIPT_PATH
  cp ./myconfig.lua $CONFIG_LITE_XL/myconfig.lua
  check
  cp ./plugins/language_v.lua $PLUG_LITE_XL/
  check
}

# Agregar la configuración
myconfig() {
  echo 'local myconfig = require("myconfig")' >>$CONFIG_LITE_XL/init.lua
  # archivo=$CONFIG_LITE_XL/init.lua
  # palabra="myconfig"
  # if grep -q "$palabra" "$archivo"; then
  #   # Ejecutar el siguiente comando una única vez.
  #   echo 'local myconfig = require("myconfig")' >>$CONFIG_LITE_XL/init.lua
  # else
  #   echo "Ya había sido configurado"
  # fi
  check
}

DP=~/gitPackages
DTERMINAL=$DP/lite-lx-terminal

# Plugin para embeber la terminal en el editor
build-terminal() {
  # https://github.com/adamharrison/lite-xl-terminal
  rm -rf $DTERMINAL
  mkdir -p $DTERMINAL
  cd $DTERMINAL
  git clone --depth=1 https://github.com/adamharrison/lite-xl-terminal.git \
    --recurse-submodules --shallow-submodules && cd lite-xl-terminal &&
    ./build.sh && cp -R plugins/terminal ~/.config/lite-xl/plugins &&
    cp libterminal.so ~/.config/lite-xl/plugins/terminal
  check
}

# Agrgar el ejecutable al menu gráfico
mkdesktop() {
  cd $SCRIPT_PATH
  cp ./logo.svg ./install-desktop.sh $DAPP/lite-xl
  cp -r linux $DAPP/lite-xl
  check
  cd $DAPP/lite-xl
  sh install-desktop.sh
  check
}

check() {
  if [[ $? -ne 0 ]]; then
    exit $?
  fi
}

help() {
  echo "
dependencies
remove
install
lsp-install
build-install # no funciona correctamente para make
config
myconfig # se lanza una única vez este comando
build-terminal
mkdesktop
"
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
