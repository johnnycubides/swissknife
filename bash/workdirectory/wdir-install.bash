#!/bin/bash

check() {
  if [[ $? -ne 0 ]]; then
    exit $?
  fi
}

update() {
  sudo apt update
}

dependencies() {
  sudo apt install \
    xsel \
    -y
}

install() {
  sudo ln -sr workdirectory.bash /usr/local/bin/wdir
}

remove() {
  sudo rm /usr/local/bin/wdir
}

# check

help() {
  echo "
update
dependencies
install
remove
"
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
