#!/bin/bash

SIMBOLS=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip

fonts() {
	cd ~/.local/share/fonts/
	wget -o fonts.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip
	unzip fonts.zip
	fc-cache -f -v
	rm -rf fonts.zip
}

dependencies() {
	sudo apt install g++
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
	ln -sr ./config/myconfig.lua $CONFIG_LUA/

	rm $PLUG_LUA/coc.lua
	rm $PLUG_LUA/ultisnips.lua
	rm $PLUG_LUA/verilog_systemverilog.lua
	rm $PLUG_LUA/verible_lsp.lua

	cp ./plugins/coc.lua $PLUG_LUA/
	cp ./plugins/ultisnips.lua $PLUG_LUA/
	# cp ./plugins/verilog_systemverilog.lua $PLUG_LUA/
	cp ./plugins/verible_lsp.lua $PLUG_LUA/

	# echo 'require("config.myconfig")' >>$CONFIG_PATCH/init.lua
}

# dependencies
# fonts
# install
config
