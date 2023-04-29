<!-- vim-markdown-toc Marked -->

* [VIM CONFIG](#vim-config)
    * [Prerequirementes](#prerequirementes)
    * [Instalación de NEOVIM](#instalación-de-neovim)
    * [Instalación de esta configuración](#instalación-de-esta-configuración)
    * [COC Instalación y plugins](#coc-instalación-y-plugins)
            * [Servidor de lenguaje lua](#servidor-de-lenguaje-lua)
            * [Servidor clangd](#servidor-clangd)
            * [Servidor de lenguaje Rust](#servidor-de-lenguaje-rust)
            * [Fast Vue Language Support](#fast-vue-language-support)
    * [Comando útiles](#comando-útiles)
    * [REFERENCIES](#referencies)
    * [VIMCOMPLETESME](#vimcompletesme)

<!-- vim-markdown-toc -->

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
sudo apt-get install git universal-ctags ncurses-term curl
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

- ✓ coc-lua Updated to v2.0.5
- ✓ coc-rls Current version 1.1.6 is up to date.
- ✓ coc-clangd Current version 0.28.0 is up to date.
- ✓ @yaegassy/coc-volar Current version 0.32.1 is up to date.
- ✓ @yaegassy/coc-volar-tools Current version 0.3.3 is up to date.

#### Servidor de lenguaje lua

```vim
:CocInstall coc-lua
```

#### Servidor clangd

```vim
:PlugInstall
:CocInstall coc-clangd
:CocInfo
```
Observación: Se requiere el **clangd** instalado; hay un comando Coc para instalar el propio Servidor
pero no es recomendable por la estabilidad al cambiar de contextos en vim. el comando es: `:CocCommand clangd.install `

Esta es la versión de clang usada en esta documentación:

```bash
Debian clangd version 14.0.6-2
Features: linux+grpc
Platform: x86_64-pc-linux-gnu
```

#### Servidor de lenguaje Rust

```bash
:CocInstall coc-rls
```

#### Fast Vue Language Support

Como el generator.vim es creado con bootstrap de vim pueda que genere conflictos
entre los plugins instalados en el generator.vim y Coc, estar pendiente de los resultados.
Se requiere explorar los comandos `CocCommand volar.*`

```bash
:CocInstall @yaegassy/coc-volar
:CocInstall @yaegassy/coc-volar-tools
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
