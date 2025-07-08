f?=main.py
p?=/dev/ttyACM0
i?=./ESP32_GENERIC_C3-20241129-v1.24.1.bin
flash_size=0x400000
baudrateFlashing=460800
# DATE=$(shell date +'-%y-%m-%d-%H-%M-%S')
DATE=$(shell date +'-%y-%m-%d')
backup=backup$(DATE).bin

help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "Examples to use"
	@echo "make putAsMain f=file.py"

erase: ## Erase flash
	esptool.py --port $p erase_flash

flash-mpy: ## Flashing esp32 memory
	esptool.py --port $p --baud $(baudrateFlashing) write_flash 0 $i # Flashing esp32c3
	# esptool.py --port $p --baud $(baudrateFlashing) write_flash 0x1000 $i # Flashing esp32 wroom

put: ## Put script in micropython
	ampy -p $p put $f

putAsMain: ## Put scritp as main.py in micropython
	cp $f main.py
	ampy -p $p put main.py

readflash: ## Read flash memory of esp32c3
	esptool.py --port $p --baud $(baudrateFlashing) read_flash 0x00000 $(flash_size) $(backup) # 4MB

chipinfo:
	@echo "#>> CHIP IP"
	@esptool.py --port $p --baud $(baudrateFlashing) chip_id
	@echo "#>> FLASH IP"
	@esptool.py --port $p --baud $(baudrateFlashing) flash_id


t: ## Serialport init
	picocom $p -b 115200
	# minicom -o -b 115200 -D $p

lstty: ## Detect serialport
	ls /dev/tty*

dmesg-w: ## dmesg-watcher
	sudo dmesg -w
