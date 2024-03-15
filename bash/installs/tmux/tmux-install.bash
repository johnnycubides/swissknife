#!/bin/bash

DP=~/gitPackages
APP=$DP/tmux

install() {
	sudo apt update
	sudo apt install tmux -y
}

config() {
	rm -rf ~/.config/tmux
	rm -rf $APP
	mkdir -p $DP
	cd $DP
	git clone https://github.com/gpakosz/.tmux.git tmux
	cd $APP
	mkdir -p ~/.config/tmux
	ln -s $APP/.tmux.conf ~/.config/tmux/tmux.conf
	cp .tmux.conf.local ~/.config/tmux/tmux.conf.local
}

# install
# config
