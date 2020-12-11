# LaTeX

## Referencias útiles

[Hacer referencias bibliograficas](https://mauricioanderson.com/curso-latex-referencias-bibliografia-bibtex/)

## Acciones útiles

### Iconos en items

En el preambulo agregar el paquete `\usepackage{amssymb}`
Luego puede ejecutar los ejemplos:

```latex
 \renewcommand{\labelitemi}{$\blacksquare$}
 \renewcommand\labelitemii{$\square$}
 \begin{itemize}
   \item  First Level
   \begin{itemize}
     \item  Second Level
     \begin{itemize}
       \item  Third Level
       \begin{itemize}
         \item  Fourth Level
       \end{itemize}
     \end{itemize}
   \end{itemize}
 \end{itemize}
```

```tex
\begin{document}
\input{src/portada.tex}
\end{document}
```

### Creación de variables

```tex
% Creación
\newcommand{\newCommandName}{Texto a insertar}
% Uso de el comando
\newCommandName{}
```
### Insertar documentos pdf

Debe agregar en el preámbulo:
```bash
\usepackage{pdfpages}
```

Donde quiera insertar puede hacer uso de la siguiente línea de ejemplo:

```
\includepdf[pages={1}, angle=90]{path/file.pdf}

```

