# Create doc with doxygen for this project #

1. build directory build_doxygen/
2. excecute doxygen command

# Subir bootloader de arduino a avr 8 #

make view_mcu

## Configuración de fuses ##
```sh
avrdude -B 40 -c usbasp -p atmega328p -U lfuse:w:0x62:m -U hfuse:w:0xd9:m -U efuse:w:0xff:m
```

## Bootloaders ##

* optiboot_atmega328.hex: Arduino @ 16Mhz externo.
* ATmegaBOOT_168_atmega328.hex: Arduino @ 16Mhz externo.
