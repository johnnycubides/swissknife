#!/bin/bash

rm -f ~/.config/nvim/init.vim ~/.config/nvim/local_bundles.vim ~/.config/nvim/vimrc_more.vim ~/.config/nvim/coc-settings.json
ln -s `pwd`/generate.vim ~/.config/nvim/init.vim
ln -s `pwd`/plugs_nvim.vim ~/.config/nvim/local_bundles.vim
ln -s `pwd`/vimrc_more ~/.config/nvim/vimrc_more.vim
ln -s `pwd`/coc-settings.json ~/.config/nvim/coc-settings.json
