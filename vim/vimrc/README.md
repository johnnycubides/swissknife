---
title: "README.md"
author: Johnny Cubides
date: Wednesday 31 October 2018
geometry: margin=2cm
output: pdf_document
---


# Por hacer después cargar los vimrc de configuración #

## tern_for_vim ##

### Instalación ###

Link [Fuente](https://github.com/ternjs/tern_for_vim)

Debe entrar al directorio de tern\_for\_vim e instalar los paquetes
dependientes de **npm**. Ejemplo:

```sh
cd ~/.vim/plugged/tern_for_vim
npm install
```

### USO ###

* **TernDef**: Jump to the definition of the thing under the cursor.

* **TernDoc**: Look up the documentation of something.

* **TernType**: Find the type of the thing under the cursor.

* **TernRefs**: Show all references to the variable or property under
    the cursor.

* **TernRename**: Rename the variable under the cursor.

## jsctags ##

Link [Fuente](urlhttps://github.com/sergioramos/jsctags)

Hay varias maneras de obtener los ctags de js en vim, se puede hacer uso
de ésta que **no se instala** directamente en el **vimrc** sino en el
proyecto que se esté desarrollando.

### Instalación ###

Ésta instalación se puede hacer de manera **global**:

```sh
npm install -g git+https://github.com/ramitos/jsctags.git
```

O para cada proyecto en el node\_modules de manera **local** agregando
en el **package.json** en la sección de **dependencies** o
**dev-dependencies**.

```sh
"jsctags": "git://github.com/ramitos/jsctags.git"
```

### USO EN VIM ###

Cómo usar tags? [fuente](https://www.cs.oberlin.edu/~kuperman/help/vim/tags.html)
Crear un tags:
```bash
find . -type f -iregex ".*\.js$" -exec jsctags {} -f \; | sed '/^$/d' | LANG=C sort > tags
```

Crear un tag ignorando un directorio:
```sh
find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | LANG=C sort > tags
```

Ahora debe abrir vim a nivel del **tags** para que carge ese tag y muestre
en el TagBar el contenido referenciado a javascript; el tagbar se puede abrir con **F4**.



