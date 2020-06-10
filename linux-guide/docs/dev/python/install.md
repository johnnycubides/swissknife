# Métodos de instalación de paquetes python

## Instalación desde fuentes

[Fuente](https://stackoverflow.com/questions/1550226/python-setup-py-uninstall)

Para instalar siempre generar el archivo *files.txt* que nos permitirá
desinstalar los archivos de manera manual cuando lo deseemos.

```python
python setup install --record files.txt
```

```bash
xargs rm -rf < files.txt
```
