# Sozi

Herramienta para desarrollar presentaciones en el navegador de manera similar
a prezi

## Documentación

[Pagina Oficial](https://sozi.baierouge.fr/)

## Instalación

Revisar los tags, en éste caso el tag a revisar es el prelanzamiento
[20.03](https://github.com/senshu/Sozi/releases/tag/v20.03-beta)

Escoger el empaquetado, en éste caso
[debian](https://github.com/senshu/Sozi/releases/download/v20.03-beta/sozi_20.03.20-1584711399_amd64.deb)

Instalar

`sudo dpkg -i sozi_20.03.20-1584711399_amd64.deb`

Si genera errores por permisos prueba lo siguiente

```bash
sudo chmod 4775 /opt/Sozi/Sozi
sudo chmod 4775 /opt/Sozi/chrome-sandbox
```

Si le genera problemas con la libreria libmpeg, pruebe pasando el opt o
haciendo una copia a `/usr/share/Sozi`
