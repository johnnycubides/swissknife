# Neovim configuración

Se requiere instalar go para la vim-go

## Descripción de archivos

* `./coc-settings.json` archivo de configuración de CoC
* `./generate.vim` archivo generado con vim bootstrap, para una nueva versión, verificar Compatibilidad
* `./plugs_nvim.vim` mis configuraciones de nvim sugetas 
* `./sh-config-nvimrc.sh` script de configuración de nvim, de pide sea instalado.

## Instalación

Dependencias

```bash
sudo apt install make cmake build-essential automake libtool-bin gettext
sudo apt-get install gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl
```

Dependencias python

[pynvim github](https://github.com/neovim/pynvim)

```bash
sudo apt install python python3 pip python3-pip
pip2 install --upgrade pynvim
pip3 install --upgrade pynvim
```

```bash
sudo apt install go
cd ~/gitPackages
git clone -b master --single-branch https://github.com/neovim/neovim.git
cd neovim/
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

**Observación**: si se tiene instalado ninja, ejecute primero
`make distclean` y después, ejecute las acciones de compilación

## Configuación

```bash
help nvim-from-vim
:call mkdir(stdpath('config'), 'p')
```

Finalemente ejecutar `./nvimrc_config.sh`

## COC instalación

En *vimrc*

```bash
Plug 'neoclide/coc.nvim', {'branch': 'release'}
```

Descargar e instalar plug `:PlugInstall`

### Plugings para coc

[coc-snippets](https://github.com/neoclide/coc-snippets)

[coc-flutter](https://github.com/iamcco/coc-flutter)

coc-snippets `:CocInstall coc-snippets`

coc-flutter `:CocInstall coc-flutter`

coc-rust `CocInstall coc-rls`

coc-python `CocInstall coc-pyright`

## Problemas

### Snippets coc no funciona generando el siguiente error

```bash
[coc.nvim] Unable to load global extension at /home/johnny/.config/coc/extensions/node_modules/coc-snippets: package.json not found 
```

**Posible solución**:

Probablemente deba iniciar con npm ese módulo, ejemplo:

```bash
cd ~/.config/coc/extensions
npm install
```

### No siver el clipboard

Instala clipboard con `sudo apt install xclip`


