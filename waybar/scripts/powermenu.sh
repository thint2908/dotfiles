#!/bin/bash

chosen=$(echo -e " Power Off\n Reboot\n Suspend\n Logout" | rofi -dmenu -p '' -no-custom -hide-scrollbar -theme-str 'entry { enabled: false; }')

case "$chosen" in
  " Power Off") systemctl poweroff ;;
  " Reboot") systemctl reboot ;;
  " Suspend") systemctl suspend ;;
  " Logout") swaymsg exit ;;
esac
