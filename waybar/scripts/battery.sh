#!/bin/bash

BATTERY=$(upower -e | grep battery | head -n 1)
AC_ADAPTER=$(upower -e | grep line_power | head -n 1)

if [[ -z "$BATTERY" || -z "$AC_ADAPTER" ]]; then
  echo "No battery"
  exit
fi

INFO=$(upower -i "$BATTERY")
STATUS=$(echo "$INFO" | grep "state" | awk '{print $2}')
PERCENT=$(echo "$INFO" | grep percentage | awk '{print $2}' | tr -d '%')

AC_ONLINE=$(upower -i "$AC_ADAPTER" | grep "online" | awk '{print $2}')

ICON=""
if [[ $STATUS == "charging" ]]; then
  ICON=""
elif [[ $STATUS == "fully-charged" || "$AC_ONLINE" == "yes" ]]; then
  ICON="󱐥"
else
  if (( PERCENT <= 20 )); then
    ICON=""
  elif (( PERCENT <= 40 )); then
    ICON=""
  elif (( PERCENT <= 60 )); then
    ICON=""
  elif (( PERCENT <= 80 )); then
    ICON=""
  else
    ICON=""
  fi
fi

echo "$ICON $PERCENT%"
