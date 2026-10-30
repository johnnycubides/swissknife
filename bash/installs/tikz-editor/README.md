# Instalación de TikZ Editor

Instalador local de [TikZ Editor, de Dominik Peters](https://github.com/DominikPeters/tikz-editor),
editor visual open source con licencia MIT. No es TikZiT ni TikzMaker.

Versión fija: [app-v1.0.0](https://github.com/DominikPeters/tikz-editor/releases/tag/app-v1.0.0).
Se usa el AppImage oficial para Linux x86_64, con verificación SHA256 del digest
publicado por la API de GitHub para ese artefacto:

```text
d0296e685404ebaac23780890d9b371beac947883164d0c28c74029a4e4c4389
```

## Instalar

Desde esta carpeta, siguiendo el esquema de los otros instaladores de Swissknife:

```bash
./tikz-editor-install.bash dependencies
./tikz-editor-install.bash install
./tikz-editor-install.bash mkdesktop
```

O ejecutar todo:

```bash
./install-all.bash all
```

* `dependencies`: instala curl, certificados y FUSE 2 con apt y sudo en
  Debian/Ubuntu. Selecciona `libfuse2t64` si está disponible, o `libfuse2`.
  No instala el paquete `fuse`, que puede interferir con FUSE 3.
* `install`: descarga y verifica el AppImage, lo guarda en
  `~/gitPackages/tikz-editor/1.0.0/` y enlaza `~/.local/bin/tikz-editor`.
  No necesita sudo ni modifica archivos del shell.
* `mkdesktop`: crea un acceso en el menú del usuario, con un icono SVG local
  genérico para diagramas, no el logotipo oficial. No cambia asociaciones de archivos.

Si `~/.local/bin` no está en tu PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Abre la aplicación desde el menú o ejecuta:

```bash
tikz-editor
```

El comando y el menú utilizan `tikz-editor.bash`, que fija `GDK_BACKEND=x11`
antes de ejecutar el AppImage y conserva los argumentos recibidos. No necesitas
escribir esa variable en cada lanzamiento. En una sesión Wayland, XWayland
debe estar disponible. Esta configuración no corrige errores ajenos al backend.

Para actualizar una instalación creada por la primera versión del instalador:

```bash
./tikz-editor-install.bash install
./tikz-editor-install.bash mkdesktop
```

Se migra el enlace directo al AppImage y el acceso de menú antiguo de esta misma
instalación. No se sustituyen comandos ni accesos ajenos.

`install` puede repetirse: verifica el archivo existente y reutiliza el enlace
correcto. Si el checksum no coincide, falla sin borrar el archivo existente.
Se rechazan comandos ajenos y accesos de escritorio preexistentes, excepto el
acceso antiguo que apuntaba directamente al AppImage de esta instalación.

## Configurar directorios

Las variables están al inicio del instalador. También puedes definir rutas
absolutas por entorno; usa los mismos valores en install y mkdesktop:

```bash
APP_DIR="$HOME/apps/tikz-editor/1.0.0" \
BIN_DIR="$HOME/bin" \
./tikz-editor-install.bash install
```

La descarga es de unos 97 MB decimales, aproximadamente 92 MiB. Se usa espacio
temporal adicional durante la instalación; después se elimina la copia temporal.
El AppImage debe permanecer en su directorio para que funcionen el enlace y el menú.

## Uso con los diagramas de Swissknife

Puedes editar figuras TikZ visualmente o mediante código. Según el README de
esta versión, admite abrir figuras existentes y documentos `.tex` con varias
figuras, y exportar SVG, PDF y PNG. Algunas construcciones avanzadas tienen
soporte parcial o no están implementadas: revisa siempre el resultado contra
LaTeX si utilizas bibliotecas complejas.

Para una salida reproducible mediante LuaLaTeX puedes seguir usando
[`../../tikz2any/`](../../tikz2any/). La previsualización visual del editor
no sustituye la validación con el motor LaTeX.

El instalador no añade TeX Live. Si necesitas compilación LaTeX, consulta las
dependencias de `tikz2any`. La aplicación anuncia asistente IA y actualizaciones
automáticas: revisa su configuración antes de utilizar documentos privados.
Este instalador fija la descarga inicial, no modifica los ajustes internos
ni desactiva las actualizaciones del editor.

## Problemas de ejecución

Si aparece un error relacionado con `libfuse.so.2`, ejecuta `dependencies`.
En entornos que no permitan montar AppImages, puedes probar la alternativa
del runtime AppImage, que extrae temporalmente y necesita espacio adicional:

```bash
APPIMAGE_EXTRACT_AND_RUN=1 tikz-editor
```

Si falla por WebKit, GTK, controladores gráficos u otra biblioteca, conserva
el mensaje y revisa los requisitos del proyecto para tu distribución. No
necesitas ejecutar la aplicación con sudo ni desactivar medidas de seguridad.

El instalador no publica ni instala un paquete del sistema. No se ofrece un
comando remoto `curl | bash`: estos archivos deben estar presentes localmente
y no se presupone que ya estén publicados en `master` remoto.
