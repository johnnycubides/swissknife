
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
