# Copiar y crear imágenes

Con permisos de SUPERUSUARIO

## Copiar imagen a dispositivo

```bash
dd if=<path>/imagen2copy of =<path>/device
```

Ejemplo

```bash
sudo dd if=recalbox-rpi2.img of=/dev/sdb
```

Para ver el proceso dec opiado puede hacer uso de `conv=fsync status=progress`

Ejemplo:

```bash
sudo dd if=recalbox-rpi2.img of=/dev/sdb conv=fsync status=progress
```
