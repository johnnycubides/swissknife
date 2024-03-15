!# /bin/bash

DP=~/gitPackages/
APP=$DP/drawio
VERSION=24.0.4
DOWNLOAD=https://github.com/jgraph/drawio-desktop/releases/download/v$VERSION/drawio-x86_64-$VERSION.AppImage

dependencies() {
	sudo apt install libfuse2
}

install() {
	mkdir -p $APP
	cd $APP
	wget -O drawio $DOWNLOAD
	chmod +x drawio
	sudo ln -sr drawio /usr/local/bin/drawio
}

# install
# dependencies
