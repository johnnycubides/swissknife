# Instalación de powerrshell-online

Dependencies

sudo apt install python3-setuptools

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

Requerimiento final

Requiere agregar el bashrc adaptado... instrucciones incompletas OJO
