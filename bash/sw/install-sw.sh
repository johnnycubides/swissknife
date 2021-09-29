#!/bin/bash -e
#						 ↑
# debug [-x -v]:[complete, abbreviated]
# Brief:	Genera el enlace simbolico para sw
# Author: Johnny Cubids
# e-mail: jgcubidesc@unal.edu.co
# date: Wednesday 29 September 2021
status=$?

sudo ln -sr sw.sh /usr/local/bin/sw
