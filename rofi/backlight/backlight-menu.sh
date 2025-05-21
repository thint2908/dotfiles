# #!/bin/bash
# options="Increase Brightness\nDecrease Brightness"
# selected=$(echo -e "$options" | rofi -dmenu -p "Brightness Control" -theme ~/.config/rofi/dracula.rasi)
# case "$selected" in
#   "Increase Brightness") brightnessctl set +5% ;;
#   "Decrease Brightness") brightnessctl set 5%- ;;
# esac


#!/bin/bash

# Giới hạn độ sáng tối đa (tính theo phần trăm)
MAX_BRIGHTNESS=100

while true; do
  # Lấy độ sáng hiện tại
  CURRENT_BRIGHTNESS=$(brightnessctl | grep -oP '\(\K[0-9]+(?=%\))')
  
  # Tùy chọn menu
  options="Increase Brightness (+5%)\nDecrease Brightness (-5%)\nExit"
  selected=$(echo -e "$options" | rofi -p "Wallpaper: $CURRENT_BRIGHTNESS%" -theme ~/.config/rofi/dracula.rasi -selected-row 0 -width 25 -lines 3 -monitor -1)

  case "$selected" in
    "Increase Brightness (+5%)")
      if [ "$CURRENT_BRIGHTNESS" -lt "$MAX_BRIGHTNESS" ]; then
        brightnessctl set +5%
        brightnessctl | grep -oP '\(\K[0-9]+(?=%\))' > /tmp/wobpipe
      fi
      ;;
    "Decrease Brightness (-5%)")
      brightnessctl set 5%-
      brightnessctl | grep -oP '\(\K[0-9]+(?=%\))' > /tmp/wobpipe
      ;;
    "Exit")
      break
      ;;
    *)
      break
      ;;
  esac
done