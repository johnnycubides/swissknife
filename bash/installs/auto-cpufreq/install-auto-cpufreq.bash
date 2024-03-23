#!/bin/bash

DAPP=~/gitPackages/

install() {
	rm -rf $DAPP/auto-cpufreq
	cd $DAPP
	git clone https://github.com/AdnanHodzic/auto-cpufreq.git
	cd auto-cpufreq
	sudo ./auto-cpufreq-installer
}

update() {
	cd $DAPP
	cd auto-cpufreq
	git pull
	sudo ./auto-cpufreq-installer
}

help() {
	echo "Terminar la instalación a través de"
	echo "auto-cpufreq-gtk"
	echo "Instalar el deamon"
}

if [[ -v 1 ]]; then
	$1
fi
