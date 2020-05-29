
Se requiere instalar go para la vim-go

## Instalación

```bash
sudo apt install go
cd ~/gitPackages
git clone -b master --single-branch https://github.com/neovim/neovim.git
cd neovim/
make CMAKE_BUILD_TYPE=RelWithDebInfo
```


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

