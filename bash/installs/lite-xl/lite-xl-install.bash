#!/bin/bash

VERSION=v2.1.3

DOWNLOAD=https://github.com/lite-xl/lite-xl/releases/download/$VERSION/lite-xl-$VERSION-addons-linux-x86_64-portable.tar.gz

DP=~/gitPackages/
APP=$DP/lite-xl
LOCAL_BIN=/usr/local/bin/
SCRIPT_PATH=$(pwd)

removelocalbin() {
	sudo rm $LOCAL_BIN/lite-xl
}

remove() {
	rm -rf $APP
	rm -rf ~/.config/lite-xl
	removelocalbin
}

install() {
	rm -rf $APP
	mkdir -p $APP
	cd $APP
	wget -O lite-xl.tar.gz $DOWNLOAD
	tar xvf lite-xl.tar.gz
	rm lite-xl.tar.gz
	cd lite-xl
	sudo ln -sr ./lite-xl $LOCAL_BIN/lite-xl
	lite-xl
}

lsp-install() {
	# https://github.com/lite-xl/lite-xl-lsp
	cd $APP
	cd ~/.config/lite-xl/
	git clone https://github.com/lite-xl/lite-xl-lsp plugins/lsp
	git clone https://github.com/lite-xl/lite-xl-widgets libraries/widget
	git clone https://github.com/liquidev/lintplus plugins/lintplus
	wget https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/snippets.lua \
		-O plugins/snippets.lua
	wget https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/lsp_snippets.lua \
		-O plugins/lsp_snippets.lua
}

CONFIG_LITE_XL=~/.config/lite-xl
PLUG_LITE_XL=$CONFIG_LITE_XL/plugins

config() {
	cd $SCRIPT_PATH
	cp ./myconfig.lua $CONFIG_LITE_XL/myconfig.lua
	cp ./plugins/language_v.lua $PLUG_LITE_XL/
	echo 'local myconfig = require("myconfig")' >>$CONFIG_LITE_XL/init.lua
}

# Paso 1 remove e install
remove
install
lsp-install
config
