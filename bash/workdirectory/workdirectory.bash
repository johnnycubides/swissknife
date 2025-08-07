#!/bin/bash -e

LISTPATH=~/projects/swissknife/bash/workdirectory/mypaths.txt
CLIP='xsel --clipboard'

function listpaths() {
  echo "==> Path config mypaths:"
  echo "$LISTPATH"
  echo "==> LISTPATH:"
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
      echo "==> Path selected:"
      echo "$path"
      echo "cd $path" | $CLIP
      echo "Save command in clip ^V"
      eval "cd $path && ls"
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
