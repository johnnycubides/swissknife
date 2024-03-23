#!/bin/sh
config() {
	mkdir -p ~/.config/zathura/
	rm -f ~/.config/zathura/zathurarc
	ln -sr ./zathurarc ~/.config/zathura/zathurarc
	echo "Configuración realizada"
}

config
