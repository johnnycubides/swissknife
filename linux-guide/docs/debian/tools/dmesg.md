# Dmesg

## Comandos útiles

**Últimos mensajes del kernel**

```bash
sudo dmesg | tail
```

**Filtrando mensajes del kernel**

```bash
sudo dmesg | grep <palabra>
```

**Mostrar solo errores y warnings**

```bash
sudo dmesg --level=warn,err
```
