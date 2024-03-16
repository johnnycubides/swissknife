#!/bin/bash

VERSION=v2.1.3

DOWNLOAD=https://github.com/lite-xl/lite-xl/releases/download/$VERSION/lite-xl-$VERSION-addons-linux-x86_64-portable.tar.gz

DP=~/gitPackages
DAPP=$DP/lite-xl
LOCAL_BIN=/usr/local/bin/
SCRIPT_PATH=$(pwd)

removelocalbin() {
	sudo rm $LOCAL_BIN/lite-xl
}

remove() {
	rm -rf $DAPP
	rm -rf ~/.config/lite-xl
	removelocalbin
}

dependencies() {
	sudo apt update
	sudo apt install \
		gcc \
		-y
}

install() {
	rm -rf $DAPP
	mkdir -p $DAPP
	cd $DAPP
	wget -O lite-xl.tar.gz $DOWNLOAD
	tar xvf lite-xl.tar.gz
	rm lite-xl.tar.gz
	cd lite-xl
	sudo ln -sr ./lite-xl $LOCAL_BIN/lite-xl
	lite-xl
}

lsp-install() {
	# https://github.com/lite-xl/lite-xl-lsp
	cd ~/.config/lite-xl/
	git clone https://github.com/lite-xl/lite-xl-lsp plugins/lsp
	git clone https://github.com/lite-xl/lite-xl-widgets libraries/widget
	git clone https://github.com/liquidev/lintplus plugins/lintplus
	wget https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/snippets.lua \
		-O plugins/snippets.lua
	wget https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/lsp_snippets.lua \
		-O plugins/lsp_snippets.lua
}

build-install() {
	cd $DP
	git clone https://github.com/adamharrison/lite-xl-ide.git
	cp -R lite-xl-ide/plugins ~/.config/lite-xl/
	rm -rf lite-xl-ide
}

CONFIG_LITE_XL=~/.config/lite-xl
PLUG_LITE_XL=$CONFIG_LITE_XL/plugins

config() {
	cd $SCRIPT_PATH
	cp ./myconfig.lua $CONFIG_LITE_XL/myconfig.lua
	cp ./plugins/language_v.lua $PLUG_LITE_XL/
}

myconfig() {
	# Ejecutar el siguiente comando una única vez.
	echo 'local myconfig = require("myconfig")' >>$CONFIG_LITE_XL/init.lua
}

DP=~/gitPackages
DTERMINAL=$DP/lite-lx-terminal

build_terminal() {
	# https://github.com/adamharrison/lite-xl-terminal
	rm -rf $DTERMINAL
	mkdir -p $DTERMINAL
	cd $DTERMINAL
	git clone --depth=1 https://github.com/adamharrison/lite-xl-terminal.git \
		--recurse-submodules --shallow-submodules && cd lite-xl-terminal &&
		./build.sh && cp -R plugins/terminal ~/.config/lite-xl/plugins &&
		cp libterminal.so ~/.config/lite-xl/plugins/terminal
}

mkdesktop() {
	cd $SCRIPT_PATH
	cp ./logo.svg ./install-desktop.sh $DAPP/lite-xl
	cp -r linux $DAPP/lite-xl
	cd $DAPP/lite-xl
	sh install-desktop.sh
}

dependencies
remove
install
lsp-install
# build-install # no funciona correctamente para make
config
myconfig # se lanza una única vez este comando
build_terminal
mkdesktop
