#!/bin/bash

VERSION=v0.39.7

install(){
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$VERSION/install.sh | bash
	echo "Restart Shell"
}

npm-install(){
	nvm install node
}
