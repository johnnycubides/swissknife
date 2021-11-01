#!/bin/bash

rm -f ~/.config/nvim/init.vim
rm -f ~/.config/nvim/local_init.vim
rm -f ~/.config/nvim/local_bundles.vim
ln -s `pwd`/generate.vim ~/.config/nvim/init.vim
ln -s `pwd`/local_init.vim ~/.config/nvim/local_init.vim
ln -s `pwd`/local_bundles.vim ~/.config/nvim/local_bundles.vim
