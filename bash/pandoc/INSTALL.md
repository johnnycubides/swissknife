# Instalación: Debian / Ubuntu

## 1. Dependencias

```bash
sudo apt update
sudo apt install pandoc librsvg2-bin \
  texlive-luatex texlive-latex-extra texlive-fonts-recommended \
  texlive-lang-spanish curl coreutils tar python3
```

* `pandoc`: Markdown/reStructuredText a HTML, PDF y Reveal.js.
* TeX Live: PDF con LuaLaTeX; ocupa un espacio considerable en disco.
* `librsvg2-bin`: proporciona `rsvg-convert`, necesario para imágenes SVG en PDF.
* `curl`, `coreutils`, `tar`: descarga y verificación de recursos Reveal.js.
* `python3`: servidor local opcional para presentar y abrir notas con **S**.

Pandoc debe ofrecer `--embed-resources`. Si el paquete de la distribución es
antiguo y no incluye esa opción, actualizar Pandoc antes de usar los conversores HTML.

## 2. Instalar los comandos

Desde `bash/pandoc/` de este repositorio, en una ruta estable:

```bash
./install-docs2any
```

Crea enlaces en `/usr/local/bin` para `md2html`, `md2pdf`, `md2reveal`,
`rst2html` y `rst2pdf`. También pueden ejecutarse directamente con `./`, sin
instalar los enlaces. No necesitan Node, reveal-md ni docutils.

## 3. Verificar

```bash
pandoc --version
pandoc --help | grep -- --embed-resources
lualatex --version
rsvg-convert --version
md2pdf --help
md2reveal --help
```

Reveal.js se obtiene al convertir: Internet es necesario en modo autocontenido
y en el primer uso de `--assets`. Las siguientes conversiones con assets
locales pueden reutilizarlos sin red. [Uso y ejemplos](README.md).
