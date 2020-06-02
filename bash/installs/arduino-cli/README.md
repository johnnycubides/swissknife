# Uso del arduino-cli

[Fuente](https://arduino.github.io/arduino-cli/getting-started/#compile-and-upload-the-sketch)

* `arduino-cli sketch new sketch-name` crear un nuevo sketch
* `arduino-cli board list` detectar la board en el pc
* `arduino-cli board listall mkr` buscar la lista de boards que soporta
* `arduino-cli core install arduino:samd` instalar el core de la board
* `arduino-cli core list` verificación de core instalado

**Nota**: El archivo de configuración será creado en `~/.arduino15/arduino-cli.yaml`

## Agregando soporte para esp8266

[Agregando soporte para esp8266](urlhttps://arduino.github.io/arduino-cli/getting-started/#adding-3rd-party-cores)
1. vim ~/.arduino15/arduino-cli.yaml

```bash
board_manager:
  additional_urls:
    - https://arduino.esp8266.com/stable/package_esp8266com_index.json
```

2. arduino-cli core update-index
3. arduino-cli core search arduino
4. arduino-cli core install esp8266:esp8266

Detectar las boards que soporta
arduino-cli board listall esp8266

## Makefile

Éste `Makefile` puede ser usado para programar sus proyectos; haga los cambios
requeridos, dependiendo del hardware `target`, puerto para programar, entre otros
