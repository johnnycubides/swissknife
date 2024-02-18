#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Iniciador de TMUX y agente de git
# Author: Johnny Cubides
# e-mail: jgcubidesc@gmail.com
# date: Thursday 12 October 2023
status=$?

ssh-add ~/.ssh/github_ryzen
ssh-add ~/.ssh/gitCatalejo
ssh-add ~/.ssh/codeberg
cd ~/projects/ && tmux
