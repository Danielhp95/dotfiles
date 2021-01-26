bluetoothctl power on
bluetoothctl agent on
device=$(bluetoothctl devices | rofi -dmenu | awk '{print $2}') 
if [ $? -eq 0 ]; then
    # This allows reconnection to a device
    bluetoothctl disconnect
    bluetoothctl connect $device
    rofi -e "Great Success!"
else
    rofi -e "Failed to connect"
fi
