#!/bin/bash

SIMBOLS=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip

fonts() {
	cd ~/.local/share/fonts/
	wget -o fonts.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip
	unzip fonts.zip
	fc-cache -f -v
	rm -rf fonts.zip
}

ripgrep() {
	echo "Instalación de ripgrep"
	VERSION=14.1.0
	DOWNLOAD=https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_$VERSION-1_amd64.deb
	wget -O ripgrep.deb $DOWNLOAD
	sudo dpkg -i ripgrep.deb
	rm -r ripgrep.deb
}

dependencies() {
	sudo apt install \
		g++ \
		plantuml \
		-y
	ripgrep
}

install() {
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git
}

CONFIG_PATCH=~/.config/nvim
CONFIG_LUA=$CONFIG_PATCH/lua/config
PLUG_LUA=$CONFIG_PATCH/lua/plugins

config() {
	rm $CONFIG_LUA/myconfig.lua
	rm $CONFIG_LUA/autocmd.lua
	rm $CONFIG_LUA/verible_lsp_config.lua
	cp ./config/myconfig.lua $CONFIG_LUA/
	cp ./config/autocmd.lua $CONFIG_LUA/
	cp ./config/verible_lsp_config.lua $CONFIG_LUA/

	rm $PLUG_LUA/coc.lua
	rm $PLUG_LUA/verible.lua
	rm $PLUG_LUA/snippet-converter.lua
	rm $PLUG_LUA/plantuml.lua
	rm $PLUG_LUA/plantuml-syntax.lua
	# rm $PLUG_LUA/ultisnips.lua
	# rm $PLUG_LUA/verilog_systemverilog.lua

	cp ./plugins/coc.lua $PLUG_LUA/
	cp ./plugins/verible.lua $PLUG_LUA/
	cp ./plugins/snippet-converter.lua $PLUG_LUA/
	cp ./plugins/plantuml.lua $PLUG_LUA/
	cp ./plugins/plantuml-syntax.lua $PLUG_LUA/
	# cp ./plugins/ultisnips.lua $PLUG_LUA/
	# cp ./plugins/verilog_systemverilog.lua $PLUG_LUA/
}

echoconfig() {
	echo 'require("config.myconfig")' >>$CONFIG_PATCH/init.lua
}

help() {
	echo "Arguments:"
	echo "dependencies"
	echo "fonts"
	echo "install"
	echo "config"
	echo "echoconfig # se debe lanzar una única vez"
}

if [[ -v 1 ]]; then
	$1
# else
# 	help
fi
