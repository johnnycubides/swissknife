# tikz2any

Conversores de TikZ a PDF y SVG mediante LuaLaTeX y Poppler. El dibujo permanece
en texto, sin editor gráfico ni servicios externos. Incluye un ejemplo de bloques
A, B y C en `example.tikz`.

## Aprender y visualizar

Consulta el [tutorial de TikZ](tutorial.md) para crear bloques, colocar nodos,
escoger puertos, trazar conexiones ortogonales, añadir etiquetas y controlar
el fondo. El [manual de PGF/TikZ](https://tikz.dev/) sirve como referencia completa.

Estas herramientas son opcionales; los conversores funcionan sin ellas:

| Herramienta | Uso recomendado | Consideración |
|---|---|---|
| [TikzMaker](https://tikzmaker.com/) | Editor visual web que genera código TikZ, con formas y componentes electrónicos | No se verificó una versión instalable para Linux ni una licencia open source. No asumir que importe cualquier TikZ existente. |
| [TikZiT](https://tikzit.github.io/) | Editor gráfico open source instalable en Linux, para nodos y conexiones | Usa un subconjunto de TikZ; no es un editor visual universal para todo el código que generemos. |
| [TeXstudio](https://www.texstudio.org/) | Editor LaTeX con visor PDF integrado | Para editar código y compilar un `.tex` completo; un fragmento `.tikz` necesita una envoltura o los conversores. |
| [Okular](https://okular.kde.org/) | Ver el PDF generado mientras editas en Neovim | Suele recargar el PDF al recompilar; muestra el resultado, no interpreta `.tikz`. |
| [Zathura](https://pwmt.org/projects/zathura/) | Alternativa ligera para visualizar PDF junto al editor | Requiere un backend PDF de la distribución. |

Para editar con el ratón, prueba TikZiT. Para trabajar con Neovim y estos scripts,
recomendamos visualizar el PDF con Okular. TikzMaker es una opción web para explorar,
pero no forma parte del flujo local ni es necesario para generar las figuras.
No subas material privado a servicios web sin la autorización correspondiente.

En Debian/Ubuntu puedes instalar opcionalmente:

```bash
sudo apt install tikzit texstudio okular
```

No se instalan con `tikz2any-install.bash`: elige solo las herramientas que necesites.
Para revisar el resultado, una vez instalado el conversor:

```bash
tikz2pdf bloques.tikz
okular bloques.pdf
# Después de editar, vuelve a ejecutar tikz2pdf en otra terminal.
```

Para SVG puedes usar un navegador o Inkscape. La recarga depende del visor;
los scripts no observan cambios ni recompilan automáticamente.

## Fondo de la imagen

Los scripts no añaden un fondo: en un fragmento normal, el área no dibujada
queda sin pintar. Un visor PDF suele mostrarla blanca, pero eso no significa
que exista un rectángulo blanco en el dibujo. El SVG conserva el área sin pintar
como transparente. Los documentos `.tex` pueden definir su propio fondo.

* Para transparencia, no dibujes fondo ni uses `\pagecolor`.
* Para un fondo explícito blanco o de color, dibuja un rectángulo en la capa
  de fondo, como muestra el [tutorial](tutorial.md#fondo-transparente-blanco-o-de-color).
* `fill=white` en un nodo pinta solo ese bloque, no el fondo completo.
* El borde de 5 mm de `standalone` es espacio adicional, no un relleno de color.

## Instalar

Desde esta carpeta:

```bash
./tikz2any-install.bash dependencies
./tikz2any-install.bash install
# O ambas acciones:
./tikz2any-install.bash all
```

`dependencies` instala, si faltan, `texlive-luatex`, `texlive-pictures`,
`texlive-latex-extra` y `poppler-utils` con apt y sudo en Debian/Ubuntu.
No necesita `pdf2svg`: usa `pdftocairo`, incluido en Poppler.

`install` crea enlaces a ambos conversores en `~/.local/bin`, sin modificar
archivos de configuración ni sustituir destinos existentes. No muevas esta
carpeta después de instalarlos. Puedes elegir otro destino:

```bash
INSTALL_DIR="$HOME/bin" ./tikz2any-install.bash install
```

Si necesitas añadir el destino al PATH de la sesión:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Convertir

```bash
tikz2pdf bloques.tikz
tikz2svg bloques.tikz
tikz2pdf "mis bloques.tikz" "build/diagrama.pdf"
tikz2svg "mis bloques.tikz" "build/diagrama.svg"
```

La carpeta de salida debe existir. Sin segundo argumento, se usa el nombre y
directorio del original con extensión `.pdf` o `.svg`. La salida existente se
reemplaza solamente después de una conversión exitosa. El original no se modifica.

También puedes ejecutarlos sin instalar:

```bash
./tikz2pdf.bash example.tikz
./tikz2svg.bash example.tikz
```

Los comandos generan los archivos, pero no abren un visor automáticamente.

## Fuentes admitidas

* `.tikz`: fragmento con `\begin{tikzpicture}` y `\end{tikzpicture}`, sin
  preámbulo ni entorno `document`. Se envuelve automáticamente con `standalone`
  y margen de 5 mm.
* `.tex`: documento completo, con su propio preámbulo y entorno `document`.
  Se conserva su tamaño de página. Para un diagrama recortado, usa `standalone`.

El PDF conserva todas las páginas; **el SVG exporta solo la primera página**.
Los elementos TikZ permanecen vectoriales; las imágenes rasterizadas incluidas
no se vuelven vectoriales. Poppler puede convertir texto a trazados en SVG.

## Bibliotecas y estilos

Para fragmentos `.tikz` se cargan `arrows.meta`, `positioning`, `calc`, `fit`,
`backgrounds` y `shapes.geometric`. Puedes añadir un preámbulo compartido:

```latex
% preamble.tex
\usetikzlibrary{decorations.pathreplacing}
\tikzset{block/.style={draw, minimum width=25mm, minimum height=15mm}}
```

```bash
TIKZ_PREAMBLE=./preamble.tex tikz2pdf figures/bloques.tikz
TIKZ_PREAMBLE=./preamble.tex tikz2svg figures/bloques.tikz
```

La ruta del preámbulo se interpreta desde el directorio donde ejecutas el comando.
Sus paquetes y estilos deben ser compatibles con el documento `standalone`.
En documentos `.tex`, el preámbulo propio controla las bibliotecas y estilos.

Para incluir el mismo fragmento desde otro documento LaTeX:

```latex
\usepackage{tikz}
\usetikzlibrary{arrows.meta}
% Dentro de document:
\input{figures/bloques.tikz}
```

Carga allí las bibliotecas y estilos que use el fragmento.

## Compilación y límites

Se compila dos veces para resolver referencias LaTeX habituales. Las inclusiones
relativas se resuelven desde la carpeta de la fuente. Los auxiliares y el PDF
intermedio de la conversión SVG son temporales y se limpian al salir; si falla
LaTeX se muestra su salida en la terminal.

El motor predeterminado es LuaLaTeX; puedes cambiarlo mediante
`LATEX_BIN=pdflatex`. No se ejecutan BibTeX, Biber ni herramientas de índices.
Shell escape está desactivado, por lo que no se admite la externalización TikZ
que necesite ejecutar comandos. Compila únicamente fuentes de confianza: desactivar
shell escape no convierte LaTeX en un entorno aislado.
