#!/bin/bash

install() {
  curl -sS https://starship.rs/install.sh | sh
}

config() {
  echo 'eval "$(starship init bash)"' >>~/.bashrc
}
