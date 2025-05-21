#!/bin/bash

# Giới hạn volume tối đa (tính theo phần trăm)
MAX_VOLUME=120

# Lấy volume hiện tại của sink mặc định
CURRENT_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)

if [ "$CURRENT_VOLUME" -lt "$MAX_VOLUME" ]; then
  pactl set-sink-volume @DEFAULT_SINK@ +1%
fi
