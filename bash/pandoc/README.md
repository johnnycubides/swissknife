# Conversores Pandoc para Markdown y reStructuredText

Esta carpeta contiene comandos sencillos para generar documentos HTML y PDF a
partir de archivos Markdown y reStructuredText. Todos los comandos aceptan una
ruta de entrada y una ruta de salida opcional.

## Instalación

```bash
./install-rst2any
```

El instalador crea estos enlaces simbólicos en `/usr/local/bin`:

```text
md2html
md2pdf
rst2html
rst2pdf
```

Cada comando también documenta sus argumentos mediante `help`, `-h` o
`--help`:

```bash
md2html --help
md2pdf --help
rst2html --help
rst2pdf --help
```

## `md2html`

Convierte un documento Markdown en un archivo HTML5 autónomo. Utiliza la
sintaxis Markdown de Pandoc y comparte `technical-report.css` con `rst2html`.

### Uso

```text
md2html INPUT_FILE [OUTPUT_FILE]
```

| Argumento | Obligatorio | Descripción |
|---|---|---|
| `INPUT_FILE` | Sí | Archivo Markdown de entrada. |
| `OUTPUT_FILE` | No | Ruta del HTML generado. |

Cuando se omite `OUTPUT_FILE`, el archivo conserva el directorio y el nombre
base de la entrada, pero utiliza la extensión `.html`:

```text
docs/report.md -> docs/report.html
```

### Opciones aplicadas por Pandoc

| Opción | Propósito |
|---|---|
| `--from=markdown` | Interpreta la entrada con Markdown de Pandoc. |
| `--to=html5` | Genera HTML5. |
| `--standalone` | Produce un documento HTML completo. |
| `--toc` | Incluye tabla de contenido. |
| `--number-sections` | Numera las secciones. |
| `--resource-path` | Resuelve recursos con relación al archivo de entrada. |
| `--css` | Aplica `technical-report.css`. |
| `--embed-resources` | Empaqueta el CSS y demás recursos dentro del HTML. |

### Ejemplos

```bash
md2html report.md
md2html report.md build/report.html
md2html docs/technical-report.md
```

## `md2pdf`

Convierte un documento Markdown en PDF mediante Pandoc y LaTeX. Comparte con
`rst2pdf` el motor LuaLaTeX predeterminado y los presets de márgenes.

### Uso

```text
md2pdf [OPTIONS] INPUT_FILE [OUTPUT_FILE]
```

| Argumento | Obligatorio | Descripción |
|---|---|---|
| `INPUT_FILE` | Sí | Archivo Markdown de entrada. |
| `OUTPUT_FILE` | No | Ruta del PDF generado. |

Cuando se omite `OUTPUT_FILE`, el archivo conserva el directorio y el nombre
base de la entrada, pero utiliza la extensión `.pdf`:

```text
docs/report.md -> docs/report.pdf
```

### Opciones de línea de comandos

| Opción | Descripción |
|---|---|
| `-m PRESET` | Selecciona un preset de márgenes. |
| `--margins PRESET` | Forma larga de `-m`. |
| `--margins=PRESET` | Forma larga con asignación directa. |
| `-h`, `--help`, `help` | Muestra la ayuda. |

### Presets y variables

| Nombre | Valor predeterminado | Descripción |
|---|---|---|
| `standard` | Sí | Una pulgada de margen en cada lado. |
| `narrow` | No | Media pulgada de margen en cada lado. |
| `wide` | No | Una pulgada y media de margen en cada lado. |
| `PDF_ENGINE` | `lualatex` | Motor PDF utilizado por Pandoc. |
| `PDF_MARGINS` | `standard` | Preset usado cuando no se pasa `--margins`. |

La opción `--margins` tiene prioridad sobre `PDF_MARGINS`.

### Opciones aplicadas por Pandoc

| Opción | Propósito |
|---|---|
| `--from=markdown` | Interpreta la entrada con Markdown de Pandoc. |
| `--standalone` | Genera un documento independiente. |
| `--toc` | Incluye tabla de contenido. |
| `--number-sections` | Numera las secciones. |
| `--resource-path` | Resuelve recursos con relación al archivo de entrada. |
| `--pdf-engine` | Selecciona LuaLaTeX de forma predeterminada. |
| `--variable=geometry:...` | Aplica el preset de márgenes. |

### Ejemplos

```bash
md2pdf report.md
md2pdf --margins narrow report.md
md2pdf -m wide report.md build/report.pdf
PDF_ENGINE=pdflatex md2pdf report.md
PDF_MARGINS=narrow md2pdf report.md
```

## `rst2html`

Convierte un documento reStructuredText en un archivo HTML5 autónomo.

### Uso

```text
rst2html INPUT_FILE [OUTPUT_FILE]
```

| Argumento | Obligatorio | Descripción |
|---|---|---|
| `INPUT_FILE` | Sí | Archivo reStructuredText de entrada. |
| `OUTPUT_FILE` | No | Ruta del HTML generado. |

Cuando se omite `OUTPUT_FILE`, el archivo de salida conserva el directorio y
el nombre base de la entrada, pero utiliza la extensión `.html`:

```text
docs/report.rst -> docs/report.html
```

### Opciones aplicadas por Pandoc

| Opción | Propósito |
|---|---|
| `--from=rst` | Interpreta la entrada como reStructuredText. |
| `--to=html5` | Genera HTML5. |
| `--standalone` | Produce un documento HTML completo. |
| `--toc` | Incluye tabla de contenido. |
| `--number-sections` | Numera las secciones. |
| `--resource-path` | Resuelve recursos con relación al archivo de entrada. |
| `--css` | Aplica `technical-report.css`. |
| `--embed-resources` | Empaqueta el CSS y demás recursos dentro del HTML. |

### Ejemplos

```bash
rst2html report.rst
rst2html report.rst build/report.html
rst2html docs/technical-report.rst
```

## `rst2pdf`

Convierte un documento reStructuredText en PDF mediante Pandoc y LaTeX.

### Uso

```text
rst2pdf [OPTIONS] INPUT_FILE [OUTPUT_FILE]
```

| Argumento | Obligatorio | Descripción |
|---|---|---|
| `INPUT_FILE` | Sí | Archivo reStructuredText de entrada. |
| `OUTPUT_FILE` | No | Ruta del PDF generado. |

Cuando se omite `OUTPUT_FILE`, el archivo de salida conserva el directorio y
el nombre base de la entrada, pero utiliza la extensión `.pdf`:

```text
docs/report.rst -> docs/report.pdf
```

### Opciones de línea de comandos

| Opción | Descripción |
|---|---|
| `-m PRESET` | Selecciona un preset de márgenes. |
| `--margins PRESET` | Forma larga de `-m`. |
| `--margins=PRESET` | Forma larga con asignación directa. |
| `-h`, `--help`, `help` | Muestra la ayuda. |

### Presets de márgenes

| Preset | Geometría LaTeX | Uso |
|---|---|---|
| `standard` | `margin=1in` | Valor predeterminado, una pulgada en cada lado. |
| `narrow` | `margin=0.5in` | Media pulgada en cada lado. |
| `wide` | `margin=1.5in` | Una pulgada y media en cada lado. |

### Variables de entorno

| Variable | Valor predeterminado | Descripción |
|---|---|---|
| `PDF_ENGINE` | `lualatex` | Motor PDF utilizado por Pandoc. |
| `PDF_MARGINS` | `standard` | Preset de márgenes usado cuando no se pasa `--margins`. |

La opción `--margins` tiene prioridad sobre `PDF_MARGINS`.

### Opciones aplicadas por Pandoc

| Opción | Propósito |
|---|---|
| `--from=rst` | Interpreta la entrada como reStructuredText. |
| `--standalone` | Genera un documento independiente. |
| `--toc` | Incluye tabla de contenido. |
| `--number-sections` | Numera las secciones. |
| `--resource-path` | Resuelve recursos con relación al archivo de entrada. |
| `--pdf-engine` | Selecciona LuaLaTeX de forma predeterminada. |
| `--variable=geometry:...` | Aplica el preset de márgenes. |

### Ejemplos

```bash
rst2pdf report.rst
rst2pdf --margins narrow report.rst
rst2pdf -m wide report.rst build/report.pdf
PDF_ENGINE=pdflatex rst2pdf report.rst
PDF_MARGINS=narrow rst2pdf report.rst
```

## Verificación rápida

```bash
bash -n md2html
bash -n md2pdf
bash -n rst2html
bash -n rst2pdf
md2html --help
md2pdf --help
rst2html --help
rst2pdf --help
```

Para probar Markdown se puede crear `report.md`:

```markdown
# Technical Report

Conversion test.
```

Y generar ambos formatos:

```bash
md2html report.md
md2pdf report.md
```

Para probar reStructuredText se puede crear `report.rst`:

```rst
Technical Report
================

Conversion test.
```

Y generar ambos formatos:

```bash
rst2html report.rst
rst2pdf report.rst
```
