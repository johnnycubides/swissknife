# wacom.sh

Mi configuración para ajustar la tableta grafica

## Todo

* Reset area
* Configurar botones

## Tabletas

Por ahora debes agregar la tableta digitalizadora de manera manual en el script `wacom.sh`;
para tal fin haz lo siguiente:

1. lista la tabletas digitalizadoras, ejemplo:
`wacom.sh list`
Retornará un resultado como el siguiente si tienes una tableta digitalizadora:
```bash
HUION Huion Tablet_HS64 Pad pad         id: 10  type: PAD       
HUION Huion Tablet_HS64 Touch Strip pad id: 11  type: PAD       
HUION Huion Tablet_HS64 stylus          id: 12  type: STYLUS
```
2. Agrega la tableta digitalizadora en la variable DEVICENAME en el script `wacom.sh`, ejemplo:
```bash
DEVICENAME="HUION Huion Tablet_HS64 stylus"
```

## Instalación

En éste directorio ejecutar

```bash
./install_wacom_sh.sh
```

