# filename: justfile
# export ZEPHYR_BASE := "/home/johnny/gitPackages/zephyr/zephyrproject/zephyr"

export ZEPHYR_BASE := "/media/johnny/bruno/opt/zephyrproject/zephyr"
ESPTOOL_PORT := "/dev/ttyACM0"
BAUD := "115200"

# VENV := ". ~/gitPackages/zephyr/.vzephy/bin/activate &&"

VENV := ". ~/miniconda3/etc/profile.d/conda.sh && conda activate zephyr &&"
BOARD := "esp32c3_supermini"
BUILD_DIR := "build"

alias b := build
alias f := flash
alias m := monitor
alias d := debug

build:
    {{ VENV }} west build -b {{ BOARD }}

flash:
    {{ VENV }} west flash -- --esp-device={{ ESPTOOL_PORT }}

monitor:
    {{ VENV }} west espressif monitor -p {{ ESPTOOL_PORT }} -b {{ BAUD }}

debug:
    {{ VENV }} west debug
    # {{ VENV }} west espressif monitor -p {{ ESPTOOL_PORT }} -b {{ BAUD }} -d

clean:
    rm -rf {{ BUILD_DIR }}/*
