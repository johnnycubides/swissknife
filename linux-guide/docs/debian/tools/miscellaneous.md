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
