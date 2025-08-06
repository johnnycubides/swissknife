#!/bin/bash -e

LISTPATH=./mypaths
CLIP='xsel --clipboard'

function listpaths() {
  if [[ -f $LISTPATH ]]; then
    nl -ba $LISTPATH
  else
    echo "El archivo $LISTPATH no existe."
  fi
}

function gotopath() {
  if [[ -f $LISTPATH ]]; then
    local path=$(sed -n "${1}p" $LISTPATH)
    if [[ -n $path ]]; then
      echo "Exec: cd $path to change path"
      echo "cd $path" | $CLIP
    else
      echo "Índice no válido."
      listpaths
    fi
  else
    echo "El archivo $LISTPATH no existe."
  fi
}

if [[ -v 1 ]]; then
  gotopath $1
else
  listpaths
fi
