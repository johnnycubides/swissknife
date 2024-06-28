#!/bin/bash

MONITOR_L=HDMI-A-0
MONITOR_R=DVI-D-0

list() {
	xrandr --listmonitors
}

# brillo-l() {
# 	xrandr --output $MONITOR_L --brightness $1
# }

# brillo-r() {
# 	xrandr --output $MONITOR_R --brightness $1
# }

day() {
	xrandr --output $MONITOR_L --gamma 1.0:1.0:1.0 --brightness $1
	xrandr --output $MONITOR_R --gamma 1.0:1.0:1.0 --brightness $2
}

night() {
	xrandr --output $MONITOR_L --gamma 1.0:0.8:0.6 --brightness $1
	xrandr --output $MONITOR_R --gamma 1.0:0.8:0.6 --brightness $2
}

help() {
	echo "
  list
  day bright_l bright_r
  night bright_l bright_r
  brillo-l [0, 1.0]
  brillo-r [0, 1.0]
"
}

if [[ -v 1 ]]; then
	$1 $2 $3
else
	help
fi
