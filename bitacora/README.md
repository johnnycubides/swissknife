# Bitacora.sh #

El objetivo de éste script es permitir guardar una secuencia de comandos que
sean usados en un directorio en la creación de un proyecto. En general cuando
se abandona un proyecto por bastante tiempo, se hace un poco complicado recordar
los comandos a usar para una tarea específica.

Es una forma de hacer documentación; pero es complementaria y debe usarse por ejemplo
para simplificar las cosas markdown, o restructuredtext entre otros.

## Instalación ##

### Dar permisos de ejecución al programa ###

```bash
chmod +x bitacora.sh
```

### Instalar para usar en cualquier lugar de desde una terminal ####

Puede instalarlo directamente...

```bash
sudo cp bitacora.sh /usr/local/bin/
```

o generar un enlace simbólico al script (recomendado)

```bash
sudo ln -sr bitacora.sh /usr/local/bin/
```

## Modo vista ##

### Ver csv desde sc ###

Instalar sc:

```bash
sudo apt install sc
```

Uso:

```bash
bitacora -sc
```

Adevertencia: si usa comillas dobles, se presenta un error en esa aplicación ya que lo
interpreta como un **String**. donde tenga **"** anteponga el **\**, ejemplo: **\"**.

### Ver desde vim ###

Desde *vim* puede leer y editar el contenido de su bitácora, si quiere tener una mejor apariencia
puede instalar el plugin para ello. Acontinuación se muestra cómo instalar el plugin

#### Instalación de plugin csv.vim (Opcional) ####

Agregar el plugin en el **vimrc**

```bash
Plug 'chrisbra/csv.vim'
```
Instalar plugin desde el modo comandos en *vim*.

```bash
:PlugInstall
```
Seleccionar el separador de elementos en el **vimrc**.

```bash
"***************************************
"       CSV
"***************************************
" definiendo el delimitador
let g:csv_delim=','
```
END.

Regards Johnny
