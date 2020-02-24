# Instalación de NGSPICE

descargar desde fuente
[sourceforge](https://sourceforge.net/projects/ngspice/)

```bash
mkdir release
cd release
../configure  --with-x --with-readline=yes --disable-debug --enable-xspice
make
sudo make install
```

