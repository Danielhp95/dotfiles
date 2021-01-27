bluetoothctl power on
bluetoothctl agent on
icon=
device=$(bluetoothctl devices | sed "s/^/$icon /" | rofi -dmenu | awk '{print $3}') 
if [ $? -eq 0 ]; then
    # This allows reconnection to a device
    bluetoothctl disconnect
    bluetoothctl connect $device
    rofi -e "Great Success!"
else
    rofi -e "Failed to connect"
fi
