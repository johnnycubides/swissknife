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

dependencies
fonts
install
