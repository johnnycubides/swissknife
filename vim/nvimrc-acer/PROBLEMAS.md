# Problemas


Please download Exuberant Ctags from ctags.sourceforge.net and install it in a directory in your $PATH or set g:tagbar_ctags_bin.

sudo apt-get install exuberant-ctags ncurses-term

PROBLEMA
Lua Inspact problemas asociados
https://github.com/xolox/vim-lua-inspect/issues

SOLUCIÓN
Hay una opción que plantea la modificación de unas líneas, de las cuales aún el autor no a aceptado.
Por ahora la opción planteada es comentar el plugin que genera el problema:

" Plug 'xolox/vim-lua-inspect'

A continuación correr el comando : PlugClean

