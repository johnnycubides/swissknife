# Conversores Pandoc para reStructuredText

Esta carpeta contiene comandos sencillos para generar documentos HTML y PDF a
partir de archivos reStructuredText. Ambos comandos aceptan una ruta de entrada
y una ruta de salida opcional.

## Instalación

```bash
./install-rst2any
```

El instalador crea estos enlaces simbólicos en `/usr/local/bin`:

```text
rst2html
rst2pdf
```

Cada comando también documenta sus argumentos mediante `help`, `-h` o
`--help`:

```bash
rst2html --help
rst2pdf --help
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
bash -n rst2html
bash -n rst2pdf
rst2html --help
rst2pdf --help
```

Para una prueba funcional, se puede crear un archivo mínimo:

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
