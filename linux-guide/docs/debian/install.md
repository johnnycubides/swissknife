# Manejo de paquetes

## Instalación

Instalación de paquetes

```bash
sudo dpkg -i package.deb
```

Búsqueda de paquetes instalados

```
dpkg -l | greep package_name

```

## Desinstalación

Desinstalación de paquetes

```bash
dpkg -r package_name
```

Remover también archivos de configuración del paquete removido

```bash
dpkg -P package_name
```
