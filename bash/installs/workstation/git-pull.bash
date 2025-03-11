#!/bin/bash

# cd ~/gitPackages/my-gnote
# pwd
# git pull
# cd ~/projects/digital-electronic-1-101/
# pwd
# git pull
# cd ~/projects/swissknife/
# pwd
# git pull

dirPrj=("$HOME/gitPackages/my-gnote" "$HOME/projects/digital-electronic-1-101/" "$HOME/projects/swissknife/")

for runner in "${dirPrj[@]}"; do
  cd $runner
  pwd
  git pull
done
