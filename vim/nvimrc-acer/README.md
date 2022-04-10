# VIM CONFIG

Esta es una configuración temporal usada en portaril acer

## Prerequirementes

```sh
sudo apt-get install git exuberant-ctags ncurses-term curl
```

## Instalación de esta configuración

```sh
./sh-config-nvimrc.sh
```

## REFERENCIES

[Uso de supertab](https://atareao.es/tutorial/vim/snippets-en-vim/)

[Inser path](https://codeyarns.com/tech/2016-10-06-how-to-autocomplete-path-in-vim-insert-mode.html)

|Command|Action|Comment|
|:-------------:|:-------------:|:-----:|
|^x^t|Inser path|mode inser|

## VIMCOMPLETESME

Vim's local keyword completion (Ctrl-X_Ctrl-N)
File path completion when typing a path (Ctrl-X_Ctrl-F)
Omni-completion after typing a character specified by g:vcm_omni_pattern (Ctrl-X_Ctrl-O)
With a b:vcm_tab_complete variable, you can set the Tab key to use the following type of completions:

Dictionary words (Ctrl-X_Ctrl-K)
User-defined completion (Ctrl-X_Ctrl-U)
Tags (Ctrl-X_Ctrl-])
Vim command line (Ctrl-X_Ctrl-V)
Omni completion (Ctrl-X_Ctrl-O)
