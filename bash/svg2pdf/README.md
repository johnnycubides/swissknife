# svg2pdf

Conversor pequeño de SVG a PDF mediante la línea de comandos de Inkscape.
Conserva gráficos vectoriales y no modifica el SVG. Inspirado en la estructura
de `../mytinypng/`, con un script de uso y otro de instalación.

## Usar sin instalar

```bash
./svg2pdf.bash "diagrama.svg"
./svg2pdf.bash "diagrama.svg" "diagrama-final.pdf"
./svg2pdf.bash --page "caratula.svg" "cover-background.pdf"
```

* Sin opciones, exporta el área del dibujo, sin el espacio sobrante de la página.
* `--page` conserva la página completa, adecuado para fondos de carátula.
* `--drawing` selecciona explícitamente el comportamiento predeterminado.
* Sin nombre de salida, escribe un PDF con el mismo nombre y directorio del SVG.
* La carpeta de salida debe existir. Las rutas con espacios se pasan entre comillas.

**Si el PDF de salida ya existe, se reemplaza después de una exportación exitosa.**
La exportación se hace primero en un temporal del mismo directorio: si Inkscape
falla, se conserva el PDF anterior y se devuelve un estado de error.

## Instalar el comando

```bash
./svg2pdf-install.bash dependencies
./svg2pdf-install.bash install
```

O ejecuta `./svg2pdf-install.bash all`. `dependencies` usa apt y sudo solo si
Inkscape falta; en otros sistemas debes instalarlo con tu gestor de paquetes.
`install` no instala dependencias ni modifica `.bashrc` o `.profile`.

Por defecto crea un enlace en `~/.local/bin/svg2pdf`. Si ese directorio ya está
en PATH, puedes usar:

```bash
svg2pdf "diagrama.svg"
svg2pdf --page "caratula.svg"
```

Si necesitas habilitar esa ruta en la sesión actual:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Puedes escoger otro destino, sin que el instalador sobrescriba archivos existentes:

```bash
INSTALL_DIR="$HOME/bin" ./svg2pdf-install.bash install
```

La instalación utiliza un enlace al script de este repositorio: no muevas la
carpeta después sin actualizar el enlace. El instalador se puede ejecutar
desde cualquier directorio, no depende del directorio actual.

## Para la plantilla LaTeX

Edita el maestro SVG en Inkscape y actualiza su PDF con este comando. LaTeX
incluye el PDF ya exportado con includegraphics; no necesita shell-escape ni
llamar a Inkscape durante la compilación.

Para una carátula con textos de LaTeX, el SVG contiene solo el arte: usa
`--page` y deja título, edición, autores y fecha en el setup del libro.

El tamaño de página, imágenes enlazadas y efectos del SVG siguen dependiendo
del documento de Inkscape. Revisa visualmente la exportación; este script
no optimiza imágenes raster ni cambia las fuentes por su cuenta.
