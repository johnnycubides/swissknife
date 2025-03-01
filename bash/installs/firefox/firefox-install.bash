#!/bin/bash

SCRIPT_PATH=$(pwd)

remove-firefox-esr() {
  sudo apt remove firefox-esr -y
}

APP=firefox
PACKAPP=$APP.tar.xz

DP=~/gitPackages
DAPP=$DP/$APP
DOWNLOAD="https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"

install() {
  rm -rf $DAPP
  sudo rm /usr/local/bin/$APP
  mkdir -p $DAPP
  cd $DAPP
  wget -O $PACKAPP $DOWNLOAD
  tar xvf $PACKAPP
  rm -f $PACKAPP
  cd $APP/
  sudo ln -sr $APP /usr/local/bin/$APP
}

update-firefox() {
  cd $DAPP
  wget -O $PACKAPP $DOWNLOAD
  tar xvf $PACKAPP
  rm -f $PACKAPP
}

desktop-file() {

  PATH_LOGO=$DAPP/firefox/browser/chrome/icons/default/default128.png
  RESOURCE_NAME=firefox

  cd $SCRIPT_PATH

  TMP_DIR=$(mktemp --directory)

  sed -e "s,<EXEC_LOCATION>,firefox,g" \
    -e "s,<ICON_LOCATION>,${PATH_LOGO},g" "${SCRIPT_PATH}/linux/desktop.template" >"${TMP_DIR}/${RESOURCE_NAME}.desktop"

  mkdir -p "${HOME}/.local/share/applications"
  cp "${TMP_DIR}/${RESOURCE_NAME}.desktop" "${HOME}/.local/share/applications/"

  mkdir -p "${HOME}/.local/share/mime/packages"
  cp "${SCRIPT_PATH}/linux/${RESOURCE_NAME}.xml" "${HOME}/.local/share/mime/packages"

  rm "${TMP_DIR}/${RESOURCE_NAME}.desktop"
  rmdir "${TMP_DIR}"

  if [ -d "${HOME}/.local/share/applications" ]; then
    if command -v update-desktop-database >/dev/null; then
      update-desktop-database "${HOME}/.local/share/applications"
    fi
  fi

  if [ -d "${HOME}/.local/share/mime" ]; then
    if command -v update-mime-database >/dev/null; then
      update-mime-database "${HOME}/.local/share/mime"
    fi
  fi
}

# remove-firefox-esr
# install
# desktop-file
# update-firefox

help() {
  echo "
remove-firefox-esr
install
desktop-file
update-firefox
  "
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
