# #!/bin/bash
# networks=$(nmcli -t -f ssid,signal dev wifi | grep -v '^$' | awk -F':' '{print $1 " (" $2 "%)"}')
# selected=$(echo "$networks" | rofi -dmenu -p "Select WiFi" -theme ~/.config/rofi/dracula.rasi)
# if [ -n "$selected" ]; then
#   ssid=$(echo "$selected" | awk '{print $1}')
#   nmcli con up "$ssid"
# fi



#!/bin/bash

while true; do
  # Lấy danh sách mạng WiFi
  networks=$(nmcli -t -f ssid,signal dev wifi | grep -v '^$' | awk -F':' '{print $1 " (" $2 "%)"}')
  if [ -z "$networks" ]; then
    networks="No WiFi networks found"
  fi

  # Hiển thị menu rofi
  selected=$(echo "$networks\nExit" | rofi -dmenu -p "Select WiFi" -theme ~/.config/rofi/dracula.rasi -selected-row 0 -width 25 -lines 5 -no-custom -monitor -1)

  # Xử lý lựa chọn
  if [ "$selected" = "Exit" ] || [ -z "$selected" ]; then
    break
  else
    ssid=$(echo "$selected" | awk '{print $1}')
    if [ -n "$ssid" ]; then
      # Kiểm tra xem SSID đã được lưu trong NetworkManager chưa
      if nmcli con show | grep -qw "$ssid"; then
        # Nếu đã lưu, kết nối trực tiếp
        nmcli con up "$ssid"
      else
        # Nếu chưa lưu, mở nm-applet để nhập mật khẩu
        nmcli dev wifi connect "$ssid" || nm-applet
      fi
    fi
  fi
done