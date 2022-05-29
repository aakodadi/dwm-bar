#!/bin/sh

# A dwm_bar function to show the current network connection/SSID, private IP, and public IP using NetworkManager
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: NetworkManager, curl

dwm_networkmanager () {
    ETH=$(nmcli -t -f DEVICE,TYPE,STATE d | grep ethernet | head -n1)
    ETH_DEVIVE=$(echo $ETH | cut -d: -f1)
    ETH_STATE=$(echo $ETH | cut -d: -f3)

    WLN=$(nmcli -t -f DEVICE,TYPE,STATE d | grep wifi | head -n1)
    WLN_DEVIVE=$(echo $WLN | cut -d: -f1)
    WLN_STATE=$(echo $WLN | cut -d: -f3)

    # PRIVATE=$(nmcli -a | grep 'inet4 192' | awk '{print $2}')
    # PUBLIC=$(curl -s https://ipinfo.io/ip)
    ETH=$(nmcli -t -f DEVICE,TYPE,STATE d | grep ethernet | head -n1)
    ETH_DEVICE=$(echo $ETH | cut -d: -f1)
    ETH_STATE=$(echo $ETH | cut -d: -f3)

    if [ "$ETH_STATE" = "connected" ]; then
        ETH_SPEED="$(cat /sys/class/net/$ETH_DEVICE/speed) Mb/s"
    else
        ETH_SPEED="down"
    fi

    WLN=$(nmcli -t -f DEVICE,TYPE,STATE d | grep wifi | head -n1)
    WLN_DEVICE=$(echo $WLN | cut -d: -f1)
    WLN_STATE=$(echo $WLN | cut -d: -f3)

    if [ "$WLN_STATE" = "connected" ]; then
        WLN_SPEED=$(iwlist wlan0 bitrate | grep "Current Bit Rate" | cut -d= -f2)
    else
        WLN_SPEED="down"
    fi
    
    # This does not work
    #export __DWM_BAR_NETWORKMANAGER__="$SEP1 $SEP1 $ETH_SPEED$SEP2$SEP1 $WLN_SPEED$SEP2$SEP2"
    
    echo -n "$SEP1 $SEP1 $ETH_SPEED$SEP2$SEP1 $WLN_SPEED$SEP2$SEP2"
}

dwm_networkmanager
