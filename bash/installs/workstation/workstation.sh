#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Iniciador de TMUX y agente de git
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date: Thursday 12 October 2023
status=$?

add-ssh-key() {
	ssh-add ~/.ssh/github
	ssh-add ~/.ssh/codeberg
	ssh-add ~/.ssh/gitlab_ryzen7
}

start-tmux() {
	cd ~/projects/ && tmux
}

add-ssh-key
start-tmux
