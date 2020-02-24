# Compilar VIM 8.2

1. Clonar archivos fuentes de VIM

2. Configurar vim

```bash
./config2compile.sh
```

3. Compilar

```bash
make VIMRUNTIMEDIR=/usr/local/share/vim/vim82 -j6
```

4. Instalar

```bash
sudo make install
```

