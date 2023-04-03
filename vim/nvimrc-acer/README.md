# VIM CONFIG

Date: Enero 16, 2023
S.O: Debian 12
Linux: 6.1.0-1
Python 3.11
Neovim Version: v0.9.0-dev-712
Esta es una configuración temporal usada en portaril acer

## Prerequirementes

Se requiere instalar estos paquetes desde los paquetes precompilados
de la distribución debian.

Ojo, no instalar exuberant-ctags hasta no probar universal-ctags
```sh
sudo apt-get install git exuberant-ctags??? ncurses-term curl
```

```bash
pip3 install pynvim
```

## Instalación de NEOVIM

En este test funcionó correctamente la instalación manual, es decir, sin
hacer uso de los precompilados de Debian.

**Observación**: puede requerir dependencias de instalación como go.

```bash
cd ~/gitPackages/
git clone -b master --single-branch https://github.com/neovim/neovim.git
cd neonvim/
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

## Instalación de esta configuración

```sh
./sh-config-nvimrc.sh
```

## COC Instalación y plugins

```bash
CocInstall coc-lua
```

## Comando útiles

* checkhealth provider: puede obervar si existe algún servicio que pueda estar fallando.

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
