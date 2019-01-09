# MADOKO

## Instalación de madoko

```bash
npm install madoko -g
```


## Servidor local

```bash
npm install madoko-local -g
```

### Uso de servidor local

```bash
madoko-local -r --port 9000 --homedir ./
```

Cuando el servicio es lanzado nodejs muestra la ruta **url** que debe ser usada; básicamente
se debe copiar y pegar en el navegador. ejemplo:

```bash
$ madoko-local -r --port 9000 --homedir ./
listening on        : http://localhost:9000
connect securely to : https://www.madoko.net
serving files under : /home/johnny/prueba
running madoko using: madoko

---------------------------------------------------------------
access server at    : http://localhost:9000#secret=yQAwZ10x36gY
---------------------------------------------------------------

type 'q' to quit.

```
En el ejemplo, la ruta al servidor es **http://localhost:9000#secret=yQAwZ10x36gY**.


