#!/bin/sh
config() {
	mkdir -p ~/.config/zathura/
	ln -sr ./zathurarc ~/.config/zathura/zathurarc
	echo "Configuración realizada"
}

config
