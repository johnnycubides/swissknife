#!/bin/bash

rm -f ~/.config/nvim/init.vim
rm -f ~/.config/nvim/local_init.vim
rm -f ~/.config/nvim/local_bundles.vim
rm -f ~/.config/nvim/coc-settings.json
rm -f ~/.config/nvim/commandHelp.vim
rm -f ~/.config/nvim/myMenu.vim
ln -s `pwd`/generate.vim ~/.config/nvim/init.vim
ln -s `pwd`/local_init.vim ~/.config/nvim/local_init.vim
ln -s `pwd`/local_bundles.vim ~/.config/nvim/local_bundles.vim
ln -s `pwd`/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s `pwd`/commandHelp.vim ~/.config/nvim/commandHelp.vim
ln -s `pwd`/myMenu.vim ~/.config/nvim/myMenu.vim
