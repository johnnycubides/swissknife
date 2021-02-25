# gnote

backup

He realizado una copia de las notas que he realizado con los siguietes comandos

```bash
cp -r ~/.local/share/gnote/ ./
```

Para hacer uso de este backup, instale gnote, remueva el directorio donde guarda
las notas y crea el enlace simbólico:

```bash
rm -rf ~/.local/share/gnote
ln -sr gnote/ ~/.local/share/gnote
```
