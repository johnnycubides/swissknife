#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
CONFIG_FILE="$SCRIPT_DIR/sw.conf"

PC_LAYOUT="latam"
PRIMARY_LAYOUT="us"
SECONDARY_LAYOUT="latam"
XKB_OPTIONS="grp:rctrl_switch,grp_led:scroll"

if [[ -f "$CONFIG_FILE" ]]; then
  source "$CONFIG_FILE"
fi

configure_x11() {
  if [[ "$MODE" == "default" ]]; then
    setxkbmap -option ''
    setxkbmap -layout "$PC_LAYOUT"
  else
    setxkbmap -option ''
    setxkbmap \
      -layout "$PRIMARY_LAYOUT,$SECONDARY_LAYOUT" \
      -option "$XKB_OPTIONS"
  fi
}

configure_gnome_wayland() {
  local schema="org.gnome.desktop.input-sources"
  local sources

  if [[ "$MODE" == "default" ]]; then
    sources="[('xkb', '$PC_LAYOUT')]"
    gsettings set "$schema" xkb-options "[]"
  else
    sources="[('xkb', '$PRIMARY_LAYOUT'), ('xkb', '$SECONDARY_LAYOUT')]"
    gsettings set "$schema" xkb-options \
      "['grp:rctrl_switch', 'grp_led:scroll']"
  fi

  gsettings set "$schema" sources "$sources"
  gsettings set "$schema" mru-sources "$sources"
}

case "${1:-}" in
"" | switch)
  MODE="switch"
  ;;
default)
  MODE="default"
  ;;
help | -h | --help)
  echo "Usage: sw [switch|default|help]"
  exit 0
  ;;
*)
  echo "Unknown command: $1" >&2
  echo "Usage: sw [switch|default|help]" >&2
  exit 1
  ;;
esac

case "${XDG_SESSION_TYPE:-}" in
x11)
  configure_x11
  ;;
wayland)
  case "${XDG_CURRENT_DESKTOP:-}" in
  *GNOME* | *gnome*)
    configure_gnome_wayland
    ;;
  *)
    echo "Unsupported Wayland desktop: ${XDG_CURRENT_DESKTOP:-unknown}" >&2
    exit 1
    ;;
  esac
  ;;
*)
  echo "Unsupported session type: ${XDG_SESSION_TYPE:-unknown}" >&2
  exit 1
  ;;
esac
