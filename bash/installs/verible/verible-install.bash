#!/bin/bash

DP=~/gitPackages
DAPP=$DP/verible
BIN=/usr/local/bin/

APPS=verible-verilog
DIFF=$APPS-diff
FORMAT=$APPS-format
KYTHE=$APPS-kythe-extractor
LINT=$APPS-lint
LS=$APPS-ls
OBFUSCATE=$APPS-obfuscate
PRE=$APPS-preprocessor
PRJ=$APPS-project
SYNTAX=$APPS-syntax

VERSION=v0.0-3756-gda9a0f8c
DOWNLOAD=https://github.com/chipsalliance/verible/releases/download/$VERSION/verible-$VERSION-linux-static-x86_64.tar.gz

removebin() {
  sudo rm $BIN$DIFF
  sudo rm $BIN$FORMAT
  sudo rm $BIN$LINT
  sudo rm $BIN$LS
  sudo rm $BIN$OBFUSCATE
  sudo rm $BIN$PRE
  sudo rm $BIN$PRJ
  sudo rm $BIN$SYNTAX
}

install() {
  removebin
  rm -rf $DAPP
  mkdir -p $DAPP
  cd $DAPP
  wget -O verible.tar.gz $DOWNLOAD
  tar xvf verible.tar.gz
  rm -rf verible.tar.gz
  mv verible-$VERSION verible
  cd verible/bin
  sudo ln -sr ./$DIFF $BIN
  sudo ln -sr ./$FORMAT $BIN
  sudo ln -sr ./$LINT $BIN
  sudo ln -sr ./$LS $BIN
  sudo ln -sr ./$OBFUSCATE $BIN
  sudo ln -sr ./$PRE $BIN
  sudo ln -sr ./$PRJ $BIN
  sudo ln -sr ./$SYNTAX $BIN
}

help() {
  echo "
  removebin
  install
  "
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
# install
