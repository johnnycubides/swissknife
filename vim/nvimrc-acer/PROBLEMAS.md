# Problemas

PROBLEMA
Please download Exuberant Ctags from ctags.sourceforge.net and install it in a directory in your $PATH or set g:tagbar_ctags_bin.

SOLUCIÓN:
sudo apt-get install exuberant-ctags ncurses-term

ACTUALIZACIÓN SOLUCIÓN
sudo apt install universal-ctags
u-ctags es compatible con tagbar

PROBLEMA
Problemas con el tagbar, es mejor revisar las opciones recomendadas en la documentación de tagbar en:
https://github.com/preservim/tagbar/wiki#typescript

PROBLEMA
Lua Inspact problemas asociados
https://github.com/xolox/vim-lua-inspect/issues

SOLUCIÓN
Hay una opción que plantea la modificación de unas líneas, de las cuales aún el autor no a aceptado.
Por ahora la opción planteada es comentar el plugin que genera el problema:

" Plug 'xolox/vim-lua-inspect'

A continuación correr el comando : PlugClean

PROBLEMA

```bash
Python 3 provider (optional) ~
- WARNING No Python executable found that can `import neovim`. Using the first available executable for diagnostics.
- WARNING Could not load Python 3:
  /usr/bin/python3 does not have the "neovim" module.
  /usr/bin/python3.10 does not have the "neovim" module.
  python3.9 not found in search path or not executable.
  python3.8 not found in search path or not executable.
  python3.7 not found in search path or not executable.
  /usr/bin/python does not have the "neovim" module.
  - ADVICE:
    - See :help |provider-python| for more information.
    - You may disable this provider (and warning) by adding `let g:loaded_python3_provider = 0` to your init.vim
- Executable: Not found
```

SOLUCIÓN

```bash
pip3 install pynvim
```
