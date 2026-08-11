# sw

Configura dos layouts de teclado y permite cambiar temporalmente al layout secundario
mediante la tecla `Ctrl` derecha.

También permite restaurar un único layout para usar el teclado sin el cambio
temporal.

## Entornos compatibles

El script selecciona el método de configuración mediante `XDG_SESSION_TYPE`:

* X11: utiliza `setxkbmap`.
* GNOME con Wayland: utiliza `gsettings`.

Otros escritorios basados en Wayland no están soportados actualmente.

## Cambio temporal

Ejecutar sin argumentos o con el comando `switch`:

```bash
./sw.sh
./sw.sh switch
```

El layout principal permanece activo normalmente. Al mantener presionada la tecla
`Ctrl` derecha se activa el layout secundario. Al soltarla se regresa al principal.
Esta tecla deja de funcionar como `Ctrl` derecha o como tecla Compose.

## Layout predeterminado

Para utilizar únicamente el layout definido en `PC_LAYOUT`:

```bash
./sw.sh default
```

Este comando elimina el cambio temporal y restaura el funcionamiento normal de la
tecla `Ctrl` derecha.

En GNOME, la configuración permanece después de reiniciar. En X11 puede ser
necesario ejecutar nuevamente el script al iniciar la sesión.

## Instalación opcional

Para instalar el comando `sw`:

```bash
./install-sw.bash install
sw
sw default
```

Para eliminarlo:

```bash
./install-sw.bash remove
```

## Configuración

Los layouts se pueden cambiar en el archivo `sw.conf`, ubicado junto a `sw.sh`:

```bash
PC_LAYOUT="latam"
PRIMARY_LAYOUT="es"
SECONDARY_LAYOUT="us"
```

`PC_LAYOUT` se utiliza con `sw default`. `PRIMARY_LAYOUT` y `SECONDARY_LAYOUT` se
utilizan con `sw` o `sw switch`.

Si `sw.conf` no existe, el script utiliza `latam` como layout del equipo, `us` como
layout principal y `latam` como layout secundario.
