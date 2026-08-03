#!/bin/bash

VERSION=v2.1.8
DOWNLOAD=https://github.com/lite-xl/lite-xl/releases/download/$VERSION/lite-xl-$VERSION-addons-linux-x86_64-portable.tar.gz
LITE_XL_SHA256=64b8ddf77cb8762c3a274b37db98f3af0859d64cbab86ab47dc9ddbcb2a8cf04

DP=${LITE_XL_PACKAGES_PATH:-$HOME/gitPackages}
DAPP=$DP/lite-xl
DTERMINAL=$DP/lite-xl-terminal
LOCAL_BIN=${LITE_XL_LOCAL_BIN:-/usr/local/bin}

CONFIG_LITE_XL=${LITE_XL_CONFIG_PATH:-$HOME/.config/lite-xl}
PLUG_LITE_XL=$CONFIG_LITE_XL/plugins
BACKUP_ROOT=${LITE_XL_BACKUP_PATH:-$HOME/.local/share/lite-xl-backups}

SCRIPT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Update each checkout and its SHA256 when updating Lite XL or its plugins.
LSP_CHECKOUT=d1432ae0736cd9531798b4bc1221835f534cc689
WIDGET_CHECKOUT=dcf1c8c7087638b879d5c9c835686ccd79f963ec
LINTPLUS_CHECKOUT=1aa6d2d0d799fa20c0fd52efaf89243424c840b0
SNIPPETS_CHECKOUT=87248a23c8ceb2507f46b3ca3689b32d35c9c709
LITE_XL_TERMINAL_CHECKOUT=b04097d2ee5affb86198001a82410fb68c94d907

SNIPPETS_SHA256=75bccc0b1a4e86f765a37d399b36ccc207ea313310a1e69152ef717e4644bc41
LSP_SNIPPETS_SHA256=5de26a79c1edb06369ca55375a00e25f16c24faaff59a6096d7f2e03aeb1c0df

removelocalbin() {
  if [[ ! -e "$LOCAL_BIN/lite-xl" && ! -L "$LOCAL_BIN/lite-xl" ]]; then
    return 0
  fi

  if [[ ! -L "$LOCAL_BIN/lite-xl" ]]; then
    echo "Refusing to remove a non-symbolic file: $LOCAL_BIN/lite-xl" >&2
    return 1
  fi

  if [[ -w "$LOCAL_BIN" ]]; then
    rm -f "$LOCAL_BIN/lite-xl"
  else
    sudo rm -f "$LOCAL_BIN/lite-xl"
  fi
}

backup() {
  local BACKUP_PATH

  if [[ ! -d "$CONFIG_LITE_XL" ]]; then
    echo "No existing Lite XL configuration to back up"
    return 0
  fi

  mkdir -p "$BACKUP_ROOT" || return 1
  BACKUP_PATH=$(mktemp -d "$BACKUP_ROOT/config-$(date +%Y%m%d-%H%M%S).XXXXXX") || return 1
  cp -a "$CONFIG_LITE_XL/." "$BACKUP_PATH/" || return 1
  echo "Configuration backup: $BACKUP_PATH"
}

remove() {
  if [[ -e "$LOCAL_BIN/lite-xl" && ! -L "$LOCAL_BIN/lite-xl" ]]; then
    echo "Refusing to remove a non-symbolic file: $LOCAL_BIN/lite-xl" >&2
    return 1
  fi

  backup
  check

  rm -rf "$DAPP"
  check
  rm -rf "$CONFIG_LITE_XL"
  check
  removelocalbin
  check
}

dependencies() {
  sudo apt update
  sudo apt install \
    build-essential \
    coreutils \
    desktop-file-utils \
    gcc \
    git \
    shared-mime-info \
    wget \
    -y
}

install() {
  local ARCHIVE=$DAPP/lite-xl.tar.gz

  rm -rf "$DAPP"
  check
  mkdir -p "$DAPP"
  check
  cd "$DAPP"
  check

  wget -O "$ARCHIVE" "$DOWNLOAD"
  check

  printf '%s  %s\n' "$LITE_XL_SHA256" "$ARCHIVE" |
    sha256sum --check --status
  check

  tar -xzf "$ARCHIVE"
  check
  rm -f "$ARCHIVE"

  if [[ ! -x "$DAPP/lite-xl/lite-xl" ]]; then
    echo "Lite XL executable was not found after extraction" >&2
    return 1
  fi

  if [[ -e "$LOCAL_BIN/lite-xl" && ! -L "$LOCAL_BIN/lite-xl" ]]; then
    echo "Refusing to replace a non-symbolic file: $LOCAL_BIN/lite-xl" >&2
    return 1
  fi

  if [[ -w "$LOCAL_BIN" ]]; then
    ln -sfn "$DAPP/lite-xl/lite-xl" "$LOCAL_BIN/lite-xl"
  else
    sudo ln -sfn "$DAPP/lite-xl/lite-xl" "$LOCAL_BIN/lite-xl"
  fi
  check

  if [[ ${LITE_XL_SKIP_LAUNCH:-0} == 1 ]]; then
    echo "Skip initial Lite XL launch"
    return 0
  fi

  if [[ -r /dev/tty ]]; then
    read \
      -p "==> Lite XL will open to create its configuration. Press ENTER, then close Lite XL to continue: " \
      -r variable </dev/tty
  fi

  echo "==> Close Lite XL after it opens so plugin installation can continue."
  "$DAPP/lite-xl/lite-xl"
  check
  echo "Lite XL closed"
}

lsp-install() {
  mkdir -p "$PLUG_LITE_XL" "$CONFIG_LITE_XL/libraries"
  check

  rm -rf \
    "$PLUG_LITE_XL/lsp" \
    "$CONFIG_LITE_XL/libraries/widget" \
    "$PLUG_LITE_XL/lintplus"
  check

  git clone https://github.com/lite-xl/lite-xl-lsp "$PLUG_LITE_XL/lsp"
  check
  git -C "$PLUG_LITE_XL/lsp" checkout "$LSP_CHECKOUT"
  check

  git clone https://github.com/lite-xl/lite-xl-widgets "$CONFIG_LITE_XL/libraries/widget"
  check
  git -C "$CONFIG_LITE_XL/libraries/widget" checkout "$WIDGET_CHECKOUT"
  check

  git clone https://github.com/liquidev/lintplus "$PLUG_LITE_XL/lintplus"
  check
  git -C "$PLUG_LITE_XL/lintplus" checkout "$LINTPLUS_CHECKOUT"
  check

  wget \
    "https://raw.githubusercontent.com/vqns/lite-xl-snippets/$SNIPPETS_CHECKOUT/snippets.lua" \
    -O "$PLUG_LITE_XL/snippets.lua"
  check

  printf '%s  %s\n' "$SNIPPETS_SHA256" "$PLUG_LITE_XL/snippets.lua" |
    sha256sum --check --status
  check

  wget \
    "https://raw.githubusercontent.com/vqns/lite-xl-snippets/$SNIPPETS_CHECKOUT/lsp_snippets.lua" \
    -O "$PLUG_LITE_XL/lsp_snippets.lua"
  check

  printf '%s  %s\n' "$LSP_SNIPPETS_SHA256" "$PLUG_LITE_XL/lsp_snippets.lua" |
    sha256sum --check --status
  check
}

build-install() {
  rm -rf "$DP/lite-xl-ide"
  check
  git clone https://github.com/adamharrison/lite-xl-ide.git "$DP/lite-xl-ide"
  check
  cp -R "$DP/lite-xl-ide/plugins" "$CONFIG_LITE_XL/"
  check
  rm -rf "$DP/lite-xl-ide"
}

config() {
  mkdir -p "$PLUG_LITE_XL"
  check
  cp "$SCRIPT_PATH/myconfig.lua" "$CONFIG_LITE_XL/myconfig.lua"
  check
  cp "$SCRIPT_PATH/plugins/language_v.lua" "$PLUG_LITE_XL/"
  check
}

myconfig() {
  local CONFIG_LINE='local myconfig = require("myconfig")'

  if grep -Fxq "$CONFIG_LINE" "$CONFIG_LITE_XL/init.lua"; then
    echo "myconfig is already enabled"
    return 0
  fi

  echo "$CONFIG_LINE" >>"$CONFIG_LITE_XL/init.lua"
  check
}

build-terminal() {
  rm -rf "$DTERMINAL"
  check
  mkdir -p "$DTERMINAL"
  check

  git clone \
    https://github.com/adamharrison/lite-xl-terminal.git \
    "$DTERMINAL/lite-xl-terminal"
  check

  cd "$DTERMINAL/lite-xl-terminal"
  check
  git checkout "$LITE_XL_TERMINAL_CHECKOUT"
  check
  git submodule update --init --recursive
  check
  ./build.sh
  check

  rm -rf "$PLUG_LITE_XL/terminal"
  check
  mkdir -p "$PLUG_LITE_XL/terminal"
  check
  cp libterminal.so "$PLUG_LITE_XL/terminal/"
  check

  # Keep the local root_dir() adaptation until the upstream issue is resolved.
  cp "$SCRIPT_PATH/plugins/terminal/init.lua" "$PLUG_LITE_XL/terminal/init.lua"
  check
}

maketoolbar() {
  rm -rf "$PLUG_LITE_XL/maketoolbar"
  check
  cp -R "$SCRIPT_PATH/plugins/maketoolbar" "$PLUG_LITE_XL/"
  check
}

mkdesktop() {
  cp \
    "$SCRIPT_PATH/logo.svg" \
    "$SCRIPT_PATH/install-desktop.sh" \
    "$DAPP/lite-xl"
  check

  rm -rf "$DAPP/lite-xl/linux"
  check
  cp -R "$SCRIPT_PATH/linux" "$DAPP/lite-xl/"
  check

  cd "$DAPP/lite-xl"
  check
  sh install-desktop.sh
  check
}

check() {
  local STATUS=$?

  if [[ $STATUS -ne 0 ]]; then
    echo "failed" >&2
    exit "$STATUS"
  fi
}

help() {
  echo "Arguments:"
  echo "  dependencies   Install required Debian packages"
  echo "  backup         Back up the current Lite XL configuration"
  echo "  remove         Back up and remove Lite XL"
  echo "  install        Install the Lite XL portable release"
  echo "  lsp-install    Install the LSP and lint plugins"
  echo "  build-install  Install the experimental build plugin"
  echo "  config         Install the local Verilog configuration"
  echo "  myconfig       Enable myconfig.lua once"
  echo "  maketoolbar    Install the Make toolbar"
  echo "  build-terminal Build and install the terminal plugin"
  echo "  mkdesktop      Install the desktop entry"
}

case "${1:-help}" in
  dependencies)
    dependencies
    ;;
  backup)
    backup
    ;;
  remove)
    remove
    ;;
  install)
    install
    ;;
  lsp-install)
    lsp-install
    ;;
  build-install)
    build-install
    ;;
  config)
    config
    ;;
  myconfig)
    myconfig
    ;;
  maketoolbar)
    maketoolbar
    ;;
  build-terminal)
    build-terminal
    ;;
  mkdesktop)
    mkdesktop
    ;;
  help)
    help
    ;;
  *)
    echo "Unknown argument: $1" >&2
    help
    exit 1
    ;;
esac
