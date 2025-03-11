#!/bin/bash

dirPrj=(
  "$HOME/gitPackages/my-gnote"
  "$HOME/projects/digital-electronic-1-101/"
  "$HOME/projects/swissknife/"
)

for runner in "${dirPrj[@]}"; do
  cd $runner
  pwd
  git pull
done
