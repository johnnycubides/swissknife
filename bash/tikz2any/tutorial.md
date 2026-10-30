# Tutorial: diagramas de bloques con TikZ

Edita un archivo `.tikz` y genera el resultado con `tikz2pdf` o `tikz2svg`.
Los comandos de este tutorial suponen que instalaste los conversores en PATH;
también puedes usar `./tikz2pdf.bash` y `./tikz2svg.bash` desde esta carpeta.

## 1. Crear bloques

Guarda como `bloques.tikz`:

```latex
\begin{tikzpicture}[
    block/.style={
        draw,
        thick,
        minimum width=25mm,
        minimum height=18mm,
        align=center
    },
    signal/.style={thick, -{Latex}}
]
    \node[block] (A) at (0,0) {Input};
    \node[block, right=30mm of A] (C) {Output};
    \node[block, below right=15mm and 10mm of A] (B) {Control};

    \draw[signal] (A.east) -- ([yshift=4mm]C.west);
    \draw[signal] (A.south) |- (B.west);
    \draw[signal] (B.east) -- ++(5mm,0) |- ([yshift=-4mm]C.west);
\end{tikzpicture}
```

```bash
tikz2pdf bloques.tikz
tikz2svg bloques.tikz
```

Los textos visibles del ejemplo están en inglés; puedes cambiar las etiquetas.
Todos los comandos TikZ terminan en `;`. El archivo `.tikz` no lleva
`\documentclass` ni `\begin{document}`.

## 2. Entender un nodo

```latex
\node[draw, minimum width=25mm] (ADC) at (0,0) {ADC};
```

| Parte | Significado |
|---|---|
| `\node` | Crea un nodo, normalmente un bloque con texto |
| `[draw, ...]` | Opciones de borde, tamaño, relleno y tipografía |
| `(ADC)` | Nombre interno para referirse al nodo |
| `at (0,0)` | Posición; las coordenadas numéricas usan cm por defecto |
| `{ADC}` | Texto visible |

El tamaño indicado es un mínimo: el texto puede agrandar el bloque.
Para texto multilínea, usa `align=center` y separa líneas con `\\`.

## 3. Posiciones absolutas y relativas

```latex
\node[block] (A) at (0,0) {A};
\node[block] (B) at (4,-3) {B};
\node[block, right=25mm of A] (C) {C};
```

* `x` aumenta hacia la derecha; `y` aumenta hacia arriba.
* `right=25mm of A` deja una separación entre los bordes de los nodos.
* También existen `left`, `above`, `below`, `above right` y `below right`.
* Las posiciones relativas necesitan `positioning`, ya cargada por el conversor
  para fragmentos `.tikz`.

No declares dos veces el mismo nombre de nodo en el dibujo definitivo.
Los ejemplos de esta sección son alternativas, no líneas para añadir todas juntas.

## 4. Puertos y puntos de conexión

Los anclajes más habituales son:

| Anclaje | Posición |
|---|---|
| `A.west` | Centro del lado izquierdo |
| `A.east` | Centro del lado derecho |
| `A.north` | Centro del lado superior |
| `A.south` | Centro del lado inferior |
| `A.center` | Centro del bloque |

Para varias entradas sobre el mismo lado, desplaza el anclaje:

```latex
\coordinate (inputTop) at ([yshift=4mm]A.west);
\coordinate (inputBottom) at ([yshift=-4mm]A.west);
\draw[signal] ([xshift=-15mm]inputTop) -- (inputTop);
\draw[signal] ([xshift=-15mm]inputBottom) -- (inputBottom);
```

Una `\coordinate` nombra un punto sin dibujar nada.

## 5. Rectas y conexiones ortogonales

```latex
\draw[signal] (A.east) -- (C.west);
\draw[signal] (A.south) |- (B.west);
\draw[signal] (A.east) -| (B.north);
```

* `--`: segmento recto; puede ser diagonal.
* `|-`: primero vertical y luego horizontal.
* `-|`: primero horizontal y luego vertical.
* `++(5mm,0)`: avanza 5 mm a la derecha y actualiza el punto actual del recorrido.

Para controlar dónde gira una conexión:

```latex
\draw[signal] (B.east) -- ++(8mm,0) |- ([yshift=-4mm]C.west);
```

TikZ no evita obstáculos automáticamente: tú eliges puntos y segmentos que no
atraviesen otros bloques. Comenta con `%` las conexiones que no quieras dibujar.

## 6. Etiquetas y estilos

```latex
\draw[signal] (A.east) -- node[midway, above] {Data} (C.west);
\draw[signal, dashed] (A.south) |- (B.west);
```

`midway` coloca la etiqueta a mitad del segmento; puedes usar `pos=0.25`.
`above`, `below`, `left` y `right` eligen su lado.

En las opciones de `tikzpicture` puedes definir estilos reutilizables:

```latex
block/.style={draw, thick, fill=blue!8, rounded corners=2mm},
signal/.style={thick, -{Latex}},
bus/.style={very thick, -{Latex}}
```

`blue!8` mezcla un 8 % de azul con blanco. Usa `\draw[bus] ...;` para una
conexión más gruesa. El estilo visual no cambia el significado de la conexión.

## Fondo transparente, blanco o de color

### Sin fondo pintado

El conversor no añade un relleno. Sin instrucciones adicionales, el exterior
de los bloques queda sin pintar. El visor PDF puede mostrar una página blanca,
y el navegador puede mostrar blanco detrás de un SVG transparente.

La transparencia se aprecia al colocar el SVG sobre un fondo de otro color.

### Fondo explícito

Añade este bloque **después de dibujar todos los nodos y conexiones**, justo antes
de `\end{tikzpicture}`:

```latex
\begin{scope}[on background layer]
    \fill[white]
        ([xshift=-3mm,yshift=-3mm]current bounding box.south west)
        rectangle
        ([xshift=3mm,yshift=3mm]current bounding box.north east);
\end{scope}
```

La biblioteca `backgrounds` ya está cargada por el conversor. Aunque se escribe
al final, la capa de fondo se dibuja detrás de los elementos. El rectángulo
abarca el dibujo y añade 3 mm de relleno por lado. Cambia `white` por `gray!10`
o cualquier color de TikZ.

El margen adicional de 5 mm del documento `standalone` queda fuera de ese
rectángulo y sigue sin pintar. Para un fondo de toda la página en un `.tex`
completo puedes usar `\usepackage{xcolor}` y `\pagecolor{white}` en el preámbulo.

`fill=white` en los bloques es distinto: solo vuelve opaco el interior de cada
bloque. `fill opacity=0.5` afecta al relleno, mientras `opacity=0.5` puede afectar
también al texto y a las líneas.

## 7. Editar con Neovim y revisar

Si `.tikz` no se reconoce como TeX, añade a `init.lua`:

```lua
vim.filetype.add({
    extension = {
        tikz = "tex",
    },
})
```

Comprueba el tipo con `:set filetype?`. El resaltado no compila ni valida el dibujo.
Abre `bloques.pdf` con Okular y vuelve a ejecutar `tikz2pdf bloques.tikz`
después de guardar. Para edición gráfica limitada a nodos y conexiones, prueba
TikZiT; un archivo arbitrario de TikZ puede usar construcciones que no soporte.
