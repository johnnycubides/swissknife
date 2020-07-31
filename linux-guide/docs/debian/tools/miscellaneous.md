# Herramientas misceláneas

### Limpiar memoria RAM

```bash
sudo -i
sync; echo X > /proc/sys/vm/drop_caches
```

Donde:

* Si `X=1` Limpia PageCache
* Si `X=2` Limpia dentries e inodes
* Si `X=3` Limpia PageCache, dentries e inodes

|Comando|Observación|Observación|
|:-------------:|:-------------:|:-----:|
|cat /etc/os-release|Ver las caracteristicas de la distribución usada en el equipo||

### Fuentes y tipografías

[Instalación de nuevas tipografías](https://www.sololinux.es/instalar-nuevas-fuentes-en-linux/)

Localización

```
cd /usr/share/fonts/
```

Recargar fuentes
```bash
sudo fc-cache -fv
```
