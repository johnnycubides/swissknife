b=9600
# b=115200
s=/dev/ttyUSB0
# s=/dev/ttyACM0
l=
SRC=
BAUDRATE=$(b)
DEVICE=$(s)
LIB=$(l)
# TARGET[uno, nano, ]
TARGET=nano

ifeq ($(TARGET),uno)
ARDUINO-TARGET=arduino:avr:uno
else ifeq ($(TARGET),nano)
ARDUINO-TARGET=arduino:avr:nano
else
ARDUINO-TARGET=arduino:avr:uno
endif

build:
	arduino-cli compile --fqbn $(ARDUINO-TARGET) $(SRC)

flash:
	arduino-cli upload -p $(DEVICE) --fqbn $(ARDUINO-TARGET) $(SRC)

clear:
ifeq ($(SRC), )
	rm -rf *.bin *.elf *.hex
else
	rm -rf $(SRC)/*.bin $(SRC)/*.elf $(SRC)/*.hex
endif

serial:
	minicom -o -b $(BAUDRATE) -D $(DEVICE)

lib2search:
ifeq ($(LIB),)
	@echo "please add l=<lib to search>"
	@echo "example: make lib2search l=TSL2591"
else
	arduino-cli lib search $(LIB)
endif

lib2install:
ifeq ($(LIB),)
	@echo "please add l=<lib to search>"
	@echo "example: make lib2install l=\"Adafruit\\ TSL2591\\ Library\""
else
	arduino-cli lib install $(LIB)
endif

b:build

f:flash

s:serial

c:clear

.PHONY: build flash clear serial b f c s
