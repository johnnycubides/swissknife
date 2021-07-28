# Instalación de powerrshell-online

## referencia:

[referencia no probada](https://colaboratorio.net/jimmy/terminal/2019/como-instalar-powerline-en-ubuntu/)

Dependencies

sudo apt install python3-setuptools fonts-powerline

Clonar repositorio

```bash
cd gitPackages/
git clone https://github.com/b-ryan/powerline-shell.git
cd powerline-shell
sudo python3 setup.py install --record files.txt
```

Configurando

```bash
ln -s `pwd`/powerline-shell/ ~/.config/
```

## ojo sin revisi'on
Requiere agregar el bashrc adaptado... instrucciones incompletas OJO
sudo apt install python3-pipe
pip install powerline-shell
