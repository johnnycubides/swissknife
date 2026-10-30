# plantuml2any

Conversores locales de PlantUML a SVG y PDF. Incluyen instalador, un
[tutorial de comandos](tutorial.md) y `example.puml` con bloques A, B y C.

## Instalar

Desde esta carpeta:

```bash
./plantuml2any-install.bash dependencies
./plantuml2any-install.bash install
# O ambas acciones:
./plantuml2any-install.bash all
```

`dependencies` comprueba PlantUML, Java, Graphviz e Inkscape; si faltan, solicita
solo sus paquetes correspondientes mediante apt y sudo en Debian/Ubuntu.
No actualiza ni reemplaza la instalación personalizada existente en
`../installs/plantuml/`. La versión disponible depende de tu instalación o de
los repositorios de tu distribución; no descarga automáticamente el último JAR.

`install` crea enlaces en `~/.local/bin` sin sustituir archivos existentes ni
editar el shell. No muevas esta carpeta después de crear los enlaces.

```bash
INSTALL_DIR="$HOME/bin" ./plantuml2any-install.bash install
export PATH="$HOME/.local/bin:$PATH"
```

## Usar

```bash
plantuml2svg bloques.puml
plantuml2pdf bloques.puml
plantuml2svg "mis bloques.puml" "build/diagrama.svg"
plantuml2pdf "mis bloques.puml" "build/diagrama.pdf"
```

Sin instalar:

```bash
./plantuml2svg.bash example.puml
./plantuml2pdf.bash example.puml
```

* Aceptan `.puml` y `.plantuml`; usa un solo diagrama por archivo.
* Sin segundo argumento, escriben junto al original con la extensión de salida.
* La carpeta de salida debe existir; pasa las rutas con espacios entre comillas.
* Solo reemplazan una salida existente después de una conversión exitosa.
* Los temporales se limpian al salir; la conversión PDF no deja un SVG intermedio.
* Los `!include` relativos se resuelven desde la carpeta del archivo fuente.
* No abren visores ni observan cambios automáticamente.

La salida SVG procede de PlantUML. El PDF se obtiene exportando esa página SVG
con Inkscape, para evitar depender de las bibliotecas opcionales de exportación
PDF de PlantUML. Las formas y líneas se mantienen vectoriales; las imágenes
rasterizadas incluidas no se convierten en vectores.

Puedes seleccionar otros ejecutables:

```bash
PLANTUML_BIN=/path/to/plantuml plantuml2svg bloques.puml
INKSCAPE_BIN=/path/to/inkscape plantuml2pdf bloques.puml
```

`PLANTUML_BIN` debe ser un ejecutable, no una cadena como `java -jar ...`.

## Fondo

El script respeta lo que genere PlantUML; no impone blanco ni transparencia.
Declara el fondo en la fuente:

```plantuml
skinparam backgroundColor transparent
```

Para fondo opaco, usa `white` o un color como `#F5F5F5`. Los bloques tienen su
propio relleno: un fondo transparente no vuelve transparentes sus interiores.
Un visor PDF puede mostrar blanco donde no hay pintura. El PDF conserva la
página SVG completa, no solo los límites visibles de las formas.

## Editores y visualización

| Herramienta | Uso |
|---|---|
| Neovim | Editar `.puml` y ejecutar los conversores en terminal; el resaltado depende de tu configuración o complemento. |
| VS Code con una extensión PlantUML | Editar y previsualizar; configura renderizado local si no quieres enviar fuentes a un servidor. |
| [PlantUML GUI](https://plantuml.com/running) | Interfaz del propio PlantUML; puedes probar `plantuml -gui` si tu Java incluye soporte gráfico. |
| [Okular](https://okular.kde.org/) | Ver el PDF generado; suele recargarlo cuando cambia. |
| [Inkscape](https://inkscape.org/) o un navegador | Inspeccionar el SVG; la recarga depende de la aplicación. |

```bash
plantuml2pdf bloques.puml
okular bloques.pdf
```

Después de editar, vuelve a ejecutar el conversor. Edita siempre el `.puml`
como fuente principal: los cambios manuales del SVG no se transfieren a PlantUML.

## Seguridad y límites

El renderizado es local, pero una fuente puede incluir direcciones remotas o
recursos externos. Estos scripts no son una sandbox ni garantizan trabajo sin red:
procesa solo fuentes de confianza y revisa sus inclusiones. Se desactiva la
incrustación de metadatos del código fuente mediante `-nometadata`; los textos
y datos visibles del diagrama siguen siendo parte del archivo exportado.

La distribución automática depende de la versión de PlantUML, Graphviz y las
fuentes instaladas. Las indicaciones direccionales y `linetype ortho` no fijan
puertos exactos ni garantizan ausencia de cruces. No se gestionan lotes,
múltiples diagramas, animaciones ni páginas múltiples en un mismo archivo.
