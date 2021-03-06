# Neovim configuración

Se requiere instalar go para la vim-go

## Instalación

```bash
sudo apt install go
cd ~/gitPackages
git clone -b master --single-branch https://github.com/neovim/neovim.git
cd neovim/
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
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

## Comandos útiles

### Spell

[nvim spell check](https://jdhao.github.io/2019/04/29/nvim_spell_check/)

* `^x, s` en modo insertar genera una lista de sugerencias
* `z=` genera una lista de sugerencias
* `]s`

### Ubicarse en la pantalla

* `zz` en la mitad
* `zt` arriba
* `zb` abajo

## Problemas

Para detectar problemas puede uar **:checkhealth** para detectar errores

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

### python neovim no instalado

```bash
pip3 install neovim
```
