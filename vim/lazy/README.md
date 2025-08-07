---
lang: es
---


# Mi configuración lazy-nvim

## Lazy plugins

Tenga presente que hay varias herramientas que se pueden instalar manualmente desde lazyvim, sin tener que pasar
por una configuración manual, en este caso he instalado:

* LuaSnip "Plug"
* catppuccin "Colorscheme"

## LazyExtras

Activar con X:
* LuaSnip

## Mason plugins

* pyrefly
* ruff
* checkmake
* clang-format
* clangd
* ltex-ls-plus
* lua-language-server lua_ls, lua_ls
* shfmt
* stylua
* verible # Instalable desde conda, verificar antes de instalar

## Others

Installations path of mason, lazy (bin)

```bash
/home/johnny/.local/share/nvim
```

Si por ejemplo se requiere actualizar el mason:

```language
cd /home/johnny/.local/share/nvim/lazy/mason.nvim
git checkout main
cd /home/johnny/.local/share/nvim/lazy/lazy.nvim
git checkout main
```

Verificar la actualización de mason:

```bash
checkhealth mason
```

## Referencias documentales

* Docs sobre configuración de un plugin: https://dev.to/vonheikemen/lazynvim-plugin-configuration-3opi
