# sw

## Configuración maunal de 

En el archivo `/etc/default/keyboard` ajustar la información de manera similar a la
mostrada a continuación:

```bash
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us,es"
XKBVARIANT=""
XKBOPTIONS="grp:rctrl_switch"

BACKSPACE="guess"
```

Dada la configuración realizada se reinicia el sistema para que tome el archivo de
configuración.

```bash
sudo udevadm trigger --subsystem-match=input --action=change
```

O esta otra función

```bash
sudo service keyboard-setup restart
```

Si desea ver posibles configuraciones del XKBOPTIONS puede ejecitar el
siguiente comando:

```bash
man xkeyboard-config
```

## Configuración con reset indeseado (no funciona bien) 

Se trata de un pequeño script para habilitar el cambio de configuración de teclado
entre el teclado inglés y el español.

- Instalación:
`./install-sw.sh`

- Uso:
Solo se requiere ejecutar en una terminal el comando `sw` y con la tecla configurada **CTRL Izq**
al mantenerla presionada habilita la configuración del teclado en español, al soltarl la tecla
el teclado permanece en configuración inglesa.

Johnny
