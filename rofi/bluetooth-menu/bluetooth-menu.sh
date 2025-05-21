#!/bin/bash
devices=$(bluetoothctl devices | awk '{print $3}')
selected=$(echo "$devices" | rofi -dmenu -p "Select Bluetooth Device" -theme ~/.config/rofi/dracula.rasi)
if [ -n "$selected" ]; then
  device_id=$(bluetoothctl devices | grep "$selected" | awk '{print $2}')
  bluetoothctl connect "$device_id"
fi