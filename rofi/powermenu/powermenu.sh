#!/bin/bash

rofi_cmd="rofi -theme ~/.config/rofi/powermenu/catppuccin.rasi \
  -show drun \
  -anchor northeast \
  -xoffset 0 \
  -yoffset 45 \
  -width 6 \
  -dmenu -p ''"

options="Power Off\nReboot\nSuspend\nLogout"

selected=$(echo -e "$options" | $rofi_cmd)

case "$selected" in
"Power Off") systemctl poweroff ;;
"Reboot") systemctl reboot ;;
"Suspend") systemctl suspend ;;
"Logout") swaymsg exit ;;
esac
