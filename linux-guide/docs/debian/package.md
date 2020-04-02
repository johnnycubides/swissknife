# Manejo de paquetes

## dpkg

### Instalación

Instalación de paquetes

```bash
sudo dpkg -i package.deb
```

Búsqueda de paquetes instalados

```
dpkg -l | greep package_name

```

### Desinstalación

Desinstalación de paquetes

```bash
dpkg -r package_name
```

Remover también archivos de configuración del paquete removido

```bash
dpkg -P package_name
```
## apt-get

Ésta aplicación permite instalaraplicaciones precompiladas en servidores
remotos.

`apt-get` es ideal para instalar paquetes base o primordiaales cuando
sea necesario, si usa `apt` este hará una actualización de paquetes
de todo tipo

Cuando se requiere hacer cambios en el sistema el uso de este comando
requiere permisos de SUPERUSUARIO.
### sourcelist

Localización de los source list

```bash
/etc/apt/sources.list
```

### Ejemplos de uso

* `apt-get install <package>` instala un paquete ya localizado en los list
* `apt-get search <package>` busca un paquetes según la palabra clave y los lista
* `apt-get update` actualiza los sourcelist
* `apt-get upgrade` actualiza los paquetes que requieren cambios según el avance en los source list
* `apt-get dist-upgrade` actualiza la versión de la distro, siempre y cuando se ajusten los source list
* `apt-get install -f` éste comando tratará de instalar paquetes retos después de una instalación fallida, en caso contrario quitará el paquete que genera problemas.

## apt

Los mismos comandos descritos en `apt-get` pueden ser usados en **apt**

* `apt install <package>` instala o actualiza paquete

## aptitude

Aptitude es eficaz en el momento de reparar paquetes rotos

* `aptitude search <package>` limpia manera de encontrar paquetes y ver su estado en el sistema

## apt-fast

Ésta aplicación complementaria a las 3 anteriores permite el manejo de hilos para descargar paquetes de manera paralela;
es ideal ya que no todos los servidores de paquetes precompilados tienen buena tasa de descarga, así mientras se descarga
un paquete lento el sistema puedo haber descargado otros 10

[fuentes](https://github.com/ilikenwf/apt-fast)

### Instalación

```bash
/bin/bash -c "$(curl -sL https://git.io/vokNn)"
```

Seguir las instrucciones de 
[configuracion](https://github.com/ilikenwf/apt-fast#configuration)

Y usar, ejemplo:

```bash
/usr/local/sbin/apt-fast upgrade
```
