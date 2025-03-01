#! /bin/bash

DOWNLOAD="https://github.com/OpenHantek/OpenHantek6022/releases/download/3.4-rc3/openhantek_3.4-rc2-15-gffd1691_amd64.deb"

wget -O openhantek.deb $DOWNLOAD

sudo dpkg -i openhantek.deb

UDEVRULES="https://raw.githubusercontent.com/OpenHantek/OpenHantek6022/refs/heads/main/utils/udev_rules/60-openhantek.rules"

RULESNAME=60-openhantek.rules

cd /etc/udev/rules.d/
sudo rm -f $RULESNAME
sudo wget -O $RULESNAME $UDEVRULES

# rm openhantek.deb
