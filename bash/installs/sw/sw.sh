#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	script para cambiar de teclado en Ingles to spanish
# Author: Johnny Cubides
# e-mail: jgcubidesc@unal.edu.co
# date: Wednesday 29 September 2021
status=$?

setxkbmap us; setxkbmap -option grp:switch,grp_led:scroll,grp:rctrl_switch us,es
