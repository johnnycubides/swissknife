# Configuración de teclado

[Documentación en españo de debian para el teclado](https://wiki.archlinux.org/index.php/Xorg_(Espa%C3%B1ol)/Keyboard_configuration_(Espa%C3%B1ol))

[Distribuciones de teclado](https://es.wikipedia.org/wiki/Distribuci%C3%B3n_del_teclado)

[Teclados IMB pc102, 102, 104, 105](https://en.wikipedia.org/wiki/IBM_PC_keyboard)

* `localectl` ver configuración local

Ejemplo de configuración de un teclado en ingles con switch a español para las tildes

```bash
localectl set-x11-keymap us,es pc104 "" grp:rctrl_switch
```



