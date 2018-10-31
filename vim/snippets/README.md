# Snippets #

La idea acá es hacer varios snippets para diferentes lenguajes en vim, de tal
manera que las modificaciones sean tenidas en cuenta y agregadas al controlador
de snippets.

## scripts ##

* **cp_snippets2here.sh**: permite hacer la copia de los Snippets creados en el directorio de **.vim**.
* **snippets_send.sh**: permite enviar una copia de varios o de todos los archivos al directorio **.vim**.

## USO de UltiSnips ##

* Inicie una palabra que esté en el snippet y luego oprima **^+j** (control + j)
* Edite un snipet ejecutando el comando **UltiSnipsEdit**

## Configuración en el vimrc ##

### Instale el plugin ###

```bash
if v:version >= 704
  "" Snippets
  Plug 'SirVer/ultisnips'
endif
```
Ejecute el siguiente comando desde vim

```bash
:PlugInstall
```
Agregue la siguiente información en su vimrc

```bash
let g:UltiSnipsListSnippets="<C-j>" "My change
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/my-snippets/UltiSnips'
"let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/plugged/vim-snippets', $HOME.'/proyectos/swissknife/vim/UltiSnips']
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/my-snippets/UltiSnips']
```

