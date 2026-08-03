# Instalación de Lite XL

1. Verificar que tenga las siguientes dependencias instaladas:

```sh
sudo apt install \
  build-essential \
  coreutils \
  desktop-file-utils \
  gcc \
  git \
  shared-mime-info \
  wget
```

También se pueden instalar mediante el script:

```bash
bash lite-xl-install.bash dependencies
```

## Instalar

Para instalar Lite XL y toda la configuración:

```bash
curl https://raw.githubusercontent.com/johnnycubides/swissknife/master/bash/installs/lite-xl/install-all.bash | bash -s all
```

La instalación utiliza Lite XL v2.1.8, verifica el SHA256 de la release y fija
las revisiones de los plugins. Antes de eliminar una configuración existente,
crea un respaldo en:

```text
~/.local/share/lite-xl-backups/
```

Durante la instalación Lite XL se abre una vez para crear `~/.config/lite-xl`.
Se debe cerrar el editor para permitir que continúe la instalación de plugins.

La configuración local agrega sintaxis y Verible LSP por separado para Verilog
(`.v`, `.vh`) y SystemVerilog (`.sv`, `.svh`). Verilog desactiva las reglas
`always-comb` y `unpacked-dimensions-range-ordering`, que requieren construcciones
propias de SystemVerilog. SystemVerilog conserva las reglas predeterminadas de
Verible.

Las operaciones también se pueden ejecutar individualmente:

```bash
bash lite-xl-install.bash help
bash lite-xl-install.bash backup
bash lite-xl-install.bash install
bash lite-xl-install.bash lsp-install
bash lite-xl-install.bash build-terminal
bash lite-xl-install.bash config
bash lite-xl-install.bash myconfig
bash lite-xl-install.bash maketoolbar
bash lite-xl-install.bash mkdesktop
```

Las versiones, checksums y revisiones están declaradas al comienzo de
`lite-xl-install.bash` para facilitar futuras actualizaciones.

## Empaquetar

Después de actualizar los scripts, configuraciones o plugins locales, se debe
reconstruir el archivo utilizado por la instalación remota:

```bash
bash install-all.bash pack
```
