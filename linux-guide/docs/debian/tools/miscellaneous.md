# Herramientas misceláneas

## Liberar SWAP

Para liberar memoria de intercambio SWAP, ejecute el siguiente
comando como super usuario.

```bash
swapoff -a && swapon -a
```

## Limpiar RAM

```bash
sudo -i
sync; echo X > /proc/sys/vm/drop_caches
```

Donde:

* Si `X=1` Limpia PageCache
* Si `X=2` Limpia dentries e inodes
* Si `X=3` Limpia PageCache, dentries e inodes

## Info distribución

|Comando|Observación|
|:-------------:|:-------------:|
|cat /etc/os-release|Ver las caracteristicas de la distribución usada en el equipo|

## Fuentes y tipografías

[Instalación de nuevas tipografías](https://www.sololinux.es/instalar-nuevas-fuentes-en-linux/)

* `sudo fc-cache -fv` : recargar fuentes en cache
* `cd /usr/share/fonts/`: lugar donde se instalan las fuentes 

## Referencias

[Limpiar memoria RAM y SWAP](https://www.tecmint.com/clear-ram-memory-cache-buffer-and-swap-space-on-linux/)
