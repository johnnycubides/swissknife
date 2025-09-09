#!/bin/bash

VERSION=v0.40.3

install() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$VERSION/install.sh | bash
  echo "Restart Shell"
}

npm-install() {
  nvm install node
}

$1
