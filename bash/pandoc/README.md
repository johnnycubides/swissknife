# Conversores Pandoc para Markdown y reStructuredText

Esta carpeta contiene comandos sencillos para generar documentos HTML y PDF a
partir de archivos Markdown y reStructuredText, además de presentaciones Reveal.js.
Todos los comandos aceptan una
ruta de entrada y una ruta de salida opcional.

## Instalación

```bash
./install-docs2any
```

El instalador crea estos enlaces simbólicos en `/usr/local/bin`:

```text
md2html
md2reveal
md2pdf
rst2html
rst2pdf
```

Cada comando también documenta sus argumentos mediante `help`, `-h` o
`--help`:

```bash
md2html --help
md2reveal --help
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

## `md2reveal`

Presentación de ejemplo lista para adaptar:
[ejemplo-presentacion.md](ejemplo-presentacion.md). Incluye separadores,
notas del presentador, tabla, código y sintaxis para añadir imágenes locales.
Desde esta carpeta:

```bash
./md2reveal ejemplo-presentacion.md
# Alternativa con recursos externos:
./md2reveal --assets ejemplo-presentacion.md
```

Convierte Markdown de **Pandoc** a una presentación Reveal.js, no a un informe
HTML. No utiliza reveal-md. Funciona directamente desde esta carpeta o mediante
el enlace creado por `install-docs2any`; no es necesario instalarlo globalmente
para probarlo.

```bash
./md2reveal charla.md
./md2reveal --assets charla.md
./md2reveal --assets docs/charla.md build/charla.html
./md2reveal --assets docs/otra.md build/otra.html
```

Sin salida explícita utiliza el directorio y nombre de la entrada con extensión
`.html`. El lienzo predeterminado es 1280×720, tema blanco y texto base de 28 px.
Para cambiarlo: `REVEAL_THEME`, `REVEAL_WIDTH` y `REVEAL_HEIGHT`. Estos valores
y el estilo común tienen prioridad sobre la configuración equivalente del
Markdown. No aplica índice ni numeración de secciones de informe. El estilo
compartido está en `reveal-slides.css`; sigue siendo necesario dividir una
diapositiva demasiado densa, no ocultar el desbordamiento.

### Modo predeterminado: HTML autocontenido

Pandoc incorpora scripts, estilos e imágenes Markdown mediante
`--embed-resources`. Cada presentación es independiente para su visualización;
enlaces hacia otros documentos no se empaquetan. La conversión requiere
Internet para obtener Reveal.js 5.2.1 desde el CDN y cualquier recurso remoto.
No crea una carpeta assets.

### `--assets`: recursos locales compartidos

No todo necesita estar dentro del HTML. La opción `--assets` crea recursos
locales junto al archivo de salida:

```text
build/
├── charla.html
├── otra.html
└── assets/
    ├── reveal.js-5.2.1/        # Runtime, temas, plugins y licencia compartidos
    ├── md2reveal.css          # Estilo común
    └── media/
        ├── charla/           # Imágenes de charla.html
        └── otra/             # Imágenes de otra.html
```

Todas las presentaciones del mismo directorio de salida reutilizan la misma
copia de Reveal.js. La primera conversión descarga el paquete oficial de npm
para esa versión fija, verifica SHA-256 y extrae recursos sin ejecutar npm ni
instalar paquetes. Las siguientes reutilizan esa copia y pueden funcionar sin
Internet si las imágenes de entrada también son locales. Un directorio de
Reveal.js incompleto o ajeno al convertidor no se sobrescribe automáticamente.
El marcador permite reconocer la instalación; no es una auditoría de integridad
de todos sus archivos después de extraerlos.

Pandoc copia las imágenes Markdown a `assets/media/<nombre-de-salida>/`.
Se separan por presentación para no sobrescribir imágenes de otras charlas que
tengan el mismo nombre. No se limpia automáticamente material de conversiones
anteriores. Volver a generar un HTML de igual nombre actualiza sus recursos;
usar nombres de salida diferentes para presentaciones distintas.

En este modo el CSS común se actualiza al convertir y afecta a todas las
presentaciones que lo comparten. Para personalizarlo, editar el estilo fuente;
no confiar en cambios manuales de la copia generada. Imágenes o recursos en
HTML crudo, enlaces externos y archivos mencionados por CSS/JavaScript propio
pueden requerir tratamiento manual: no se garantiza copiar dependencias
arbitrarias. Conservar HTML y assets juntos para trasladar la presentación.

### Sintaxis y notas del presentador

```markdown
# Primera diapositiva

Contenido visible.

::: notes
Estas notas solo aparecen en la vista del presentador.
:::

---

# Segunda diapositiva

![Imagen](images/ejemplo.png){height=320px}
```

Los recursos se resuelven respecto al archivo Markdown, incluso al generar
en otro directorio. Para abrir las notas, servir el directorio de salida:

```bash
cd build
python3 -m http.server 8765 --bind 127.0.0.1
```

Abrir `http://127.0.0.1:8765/charla.html` y pulsar **S**. Permitir ventanas
emergentes y compartir solo la ventana de diapositivas. El script no inicia
servidores ni abre navegadores por su cuenta.

### Requisitos

Bash, Pandoc con soporte de `--embed-resources`, `realpath` y `readlink -f`.
El modo assets añade `curl`, `sha256sum` y `tar`. No necesita Node, reveal-md
ni LaTeX. El motor de renderizado y la plantilla disponibles dependen de la
versión de Pandoc; verificar su versión al diagnosticar incompatibilidades.

Pruebas de regresión locales, sin descargas y con Pandoc simulado, desde la
raíz de swissknife:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest discover \
  -s bash/pandoc -p test_md2reveal.py -v
```

Validación de integración realizada el 2026-10-20 con Pandoc 3.11 y Reveal.js
5.2.1: conversión real de ambos modos, reutilización sin red del runtime local,
imágenes en rutas con espacios y ventana de notas en Chromium. Las notas se
comprobaron ocultas al público y visibles al pulsar S. Esto no garantiza que
cualquier documento arbitrariamente denso quepa en una diapositiva.

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
