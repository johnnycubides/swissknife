#!/bin/bash

# foreground
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
NC=$(tput setaf 7)
# background
BLACKB=$(tput setab 0)
REDB=$(tput setab 1)
GREENB=$(tput setab 2)
YELLOWB=$(tput setab 3)
BLUEB=$(tput setab 4)
MAGENTAB=$(tput setab 5)
CYANB=$(tput setab 6)
WHITEB=$(tput setab 7)
NCB=$(tput setab 0)

dirPrj=(
  "$HOME/gitPackages/my-gnote/"
  "$HOME/projects/digital-electronic-1-101/"
  "$HOME/projects/swissknife/"
  "$HOME/projects/maloka-prj/"
  "$HOME/projects/catalejo-lua/"
  "$HOME/projects/catalejo-vue3-desktop-v2/"
  "$HOME/projects/catalejo-editor-desktop/docs/catalejo-luabot-esp8266-docs"
  "$HOME/projects/lua-testbench"
  "$HOME/projects/nodemcu-plugin-catalejo-editor"
)

for runner in "${dirPrj[@]}"; do
  cd $runner
  echo "==========================="
  echo "### 1. GIT REPO ###"
  printf "${GREEN}${PWD}${NC}\n"
  echo "### 2. GIT STATUS ###"
  git status
  echo "### 3. GIT PULL ###"
  git pull
done
