# Instalación de lite-xl

Solo se requiere ejecutar el siguiente comando:

```
curl https://raw.githubusercontent.com/johnnycubides/swissknife/master/bash/installs/lite-xl/install-all.bash | bash -s all
```

## Empaquetar

Solo se usa el siguiente comando en el caso de hacer actualizaciones de estas fuentes.

```bash
rm -rf lite-xl-config.tar.gz
tar -czvf lite-xl-config.tar.gz install-desktop.sh linux lite-xl-install.bash logo.svg myconfig.lua plugins
```
