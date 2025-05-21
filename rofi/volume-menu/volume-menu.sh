# #!/bin/bash

# # Giới hạn volume tối đa (tính theo phần trăm)
# MAX_VOLUME=120

# # Lấy volume hiện tại của sink mặc định
# CURRENT_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)

# if [ "$CURRENT_VOLUME" -lt "$MAX_VOLUME" ]; then
#   pactl set-sink-volume @DEFAULT_SINK@ +1%
# fi

# options="Increase Volume\nDecrease Volume\nMute\nOpen pavucontrol"
# selected=$(echo -e "$options" | rofi -dmenu -p "Volume Control" -theme ~/.config/rofi/dracula.rasi)
# case "$selected" in
#   "Increase Volume") if [ "$CURRENT_VOLUME" -lt "$MAX_VOLUME" ]; then
#                         pactl set-sink-volume @DEFAULT_SINK@ +1%
#                     fi ;;
#   "Decrease Volume") pactl set-sink-volume @DEFAULT_SINK@ -1% ;;
#   "Mute") pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
#   "Open pavucontrol") pavucontrol ;;
# esac


#!/bin/bash

# Giới hạn volume tối đa (tính theo phần trăm)
MAX_VOLUME=120

while true; do
  # Lấy volume hiện tại của sink mặc định
  CURRENT_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
  # Lấy trạng thái mute
  MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP 'Mute: \K\w+')
  
  # Cập nhật prompt với trạng thái volume
  if [ "$MUTE_STATUS" = "yes" ]; then
    PROMPT="Volume: Muted"
  else
    PROMPT="Volume: $CURRENT_VOLUME%"
  fi

  # Tùy chọn menu
  options="Increase Volume (+1%)\nDecrease Volume (-1%)\nMute/Unmute\nOpen pavucontrol\nExit"
  selected=$(echo "$options" | rofi -dmenu -p "$PROMPT" -theme ~/.config/rofi/dracula.rasi -selected-row 0 -width 25 -lines 5 -no-custom -monitor -1)

  case "$selected" in
    "Increase Volume (+1%)")
      if [ "$CURRENT_VOLUME" -lt "$MAX_VOLUME" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +1%
        pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1 > /tmp/wobpipe
      fi
      ;;
    "Decrease Volume (-1%)")
      pactl set-sink-volume @DEFAULT_SINK@ -1%
      pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1 > /tmp/wobpipe
      ;;
    "Mute/Unmute")
      pactl set-sink-mute @DEFAULT_SINK@ toggle
      if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP 'Mute: \K\w+')" = "yes" ]; then
        echo 0 > /tmp/wobpipe
      else
        pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1 > /tmp/wobpipe
      fi
      ;;
    "Open pavucontrol")
      pavucontrol &
      break
      ;;
    "Exit")
      break
      ;;
    *)
      break
      ;;
  esac
done