#!/bin/bash

SIMBOLS=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip

fonts() {
  DIRFONTS=~/.local/share/fonts/
  mkdir -p $DIRFONTS
  cd $DIRFONTS
  wget -O fonts.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip
  unzip fonts.zip
  fc-cache -f -v
  rm -rf fonts.zip
}

ripgrep() {
  echo "Instalación de ripgrep"
  VERSION=14.1.0
  DOWNLOAD=https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_$VERSION-1_amd64.deb
  wget -O ripgrep.deb $DOWNLOAD
  sudo dpkg -i ripgrep.deb
  rm -r ripgrep.deb
}

cargo_dependencies() {
  echo "cargo dependencies vacío"
  # cargo install ast-grep --frozen
}

npm_dependencies() {
  npm install -g neovim
  npm install -g @ast-grep/cli
  # npm install -g tree-sitter
}

dependencies() {
  # python-is-python3 en el caso de tener problemas con la variable de entorno
  sudo apt install \
    g++ \
    fd-find \
    python3-venv \
    golang \
    python-is-python3 \
    fswatch \
    -y
  ripgrep
  npm_dependencies
  cargo_dependencies
}

install() {
  # Clean
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.cache/nvim:
  # clone starter
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
}

CONFIG_PATCH=~/.config/nvim
CONFIG_LUA=$CONFIG_PATCH/lua/config
PLUG_LUA=$CONFIG_PATCH/lua/plugins

config() {
  #############################
  ## CONFIG
  #############################
  ## CONFIGURACIONES REMOVE ##
  rm $CONFIG_LUA/myconfig.lua
  rm $CONFIG_LUA/autocmd.lua
  rm $CONFIG_LUA/lsp-config.lua
  # rm $CONFIG_LUA/verible_lsp_config.lua

  ## CONFIGURACIONES INSTAll ##
  cp ./config/myconfig.lua $CONFIG_LUA/
  cp ./config/autocmd.lua $CONFIG_LUA/
  cp ./config/lsp-config.lua $CONFIG_LUA/
  # cp ./config/verible_lsp_config.lua $CONFIG_LUA/

  #############################
  ## PLUGINS
  #############################
  ## PLUGINS REMOVE ##
  # rm $PLUG_LUA/example.lua
  # rm $PLUG_LUA/aerial.lua
  rm $PLUG_LUA/plantuml-syntax.lua
  rm $PLUG_LUA/plantuml.lua
  # LSP
  rm $PLUG_LUA/typescript-tools.lua
  # rm $PLUG_LUA/mason-lsp-config.lua
  # rm $PLUG_LUA/vue-language-tools.lua
  # rm $PLUG_LUA/verible.lua
  # rm $PLUG_LUA/coc.lua
  rm $PLUG_LUA/snippet-converter.lua
  rm $PLUG_LUA/markdown-preview.lua
  # rm $PLUG_LUA/gentags.lua
  # rm $PLUG_LUA/mason.lua
  # rm $PLUG_LUA/ultisnips.lua
  # rm $PLUG_LUA/verilog_systemverilog.lua
  rm $PLUG_LUA/nvim-cmp.lua
  rm $PLUG_LUA/miscellaneous.lua
  rm $PLUG_LUA/luasnip.lua

  ## PLUGINS INSTALL ##
  # cp $PLUG_LUA/example.lua ./plugins/
  # cp ./plugins/aerial.lua $PLUG_LUA/
  cp ./plugins/plantuml-syntax.lua $PLUG_LUA/
  cp ./plugins/plantuml.lua $PLUG_LUA/
  # LSP
  cp ./plugins/typescript-tools.lua $PLUG_LUA/ # Este es el plugin adecuado
  # cp ./plugins/mason-lsp-config.lua $PLUG_LUA/
  # cp ./plugins/vue-language-tools.lua $PLUG_LUA/ # este requiere tsserver, se requiere buscar mejoras para que funcione con typescript-tools
  # cp ./plugins/verible.lua $PLUG_LUA/
  # cp ./plugins/coc.lua $PLUG_LUA/
  cp ./plugins/snippet-converter.lua $PLUG_LUA/
  cp ./plugins/markdown-preview.lua $PLUG_LUA/
  # cp ./plugins/gentags.lua $PLUG_LUA/
  # cp ./plugins/ultisnips.lua $PLUG_LUA/
  # cp ./plugins/verilog_systemverilog.lua $PLUG_LUA/
  # cp ./plugins/mason.lua $PLUG_LUA/
  # cp ./plugins/example.lua $PLUG_LUA/
  cp ./plugins/nvim-cmp.lua $PLUG_LUA/
  cp ./plugins/miscellaneous.lua $PLUG_LUA/
  cp ./plugins/luasnip.lua $PLUG_LUA/
}

myconfig() {
  echo 'require("config.myconfig")' >>$CONFIG_PATCH/init.lua
}

check() {
  if [[ $? -ne 0 ]]; then
    exit $?
  fi
}

all() {
  fonts
  dependencies
  install
  config
  myconfig
}

help() {
  echo "Arguments:"
  echo "dependencies"
  echo "fonts"
  echo "install"
  echo "config"
  echo "myconfig # se debe lanzar una única vez"
  echo "Instalar manualmente Verible, plantuml"
  echo " Antes de agregar más plugin manualmente, verifique la documentación de lazyvim ya que desde EXTAS puede estar listo para cargar, como por ejemplo LuaSnips"
}

if [[ -v 1 ]]; then
  $1
else
  help
fi
