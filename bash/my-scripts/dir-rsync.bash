#!/bin/bash

LOCAL=./books/
REMOTE=/media/johnny/johnny1/books/

pull() {
  rsync -avni --progress --delete $LOCAL $REMOTE
  info
  read -p "Are you shure of make pull, send docs from $REMOTE to $LOCAL? y/n: " -r keyboard
  if [ "$keyboard" = "y" ]; then
    rsync -avh --progress --delete $REMOTE $LOCAL
    sync
    echo "Finished process"
  fi
}

push() {
  rsync -avni --progress --delete $LOCAL $REMOTE
  info
  read -p "Are you shure of make push, send docs from $LOCAL to $REMOTE? y/n: " -r keyboard
  if [ "$keyboard" = "y" ]; then
    rsync -avh --progress --delete $LOCAL $REMOTE
    sync
    echo "Finished process"
  fi
}

info() {
  echo "INFO:
>f → archivo que se copiaría desde origen a destino.
.f → archivo ya existente, pero con metadatos distintos (permisos, fechas).
cd → directorio creado.
*deleting → archivo que se eliminaría en destino (si usas --delete).
"
}

$1
