#!/bin/bash

DP=~/gitPackages
GITUI_VERSION=v0.27.0
DGUI=$DP/gitui

dependencies() {
  sudo apt update
  sudo apt install git -y
}

install() {
  mkdir -p $DGUI
  cd $DGUI
  wget -O "gitui.tar.gz" "https://github.com/extrawurst/gitui/releases/download/$GITUI_VERSION/gitui-linux-x86_64.tar.gz"
  tar xvf gitui.tar.gz
  rm gitui.tar.gz
  chmod +x gitui
  sudo rm /usr/local/bin/gitui
  sudo ln -sr gitui /usr/local/bin
}

help() {
  echo "
dependencies
install
  "
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
