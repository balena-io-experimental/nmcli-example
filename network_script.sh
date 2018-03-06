#!/bin/bash

#using this location for running natively on the raspberry pi stretch image, no resin.
#export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/var/run/dbus/system_bus_socket

#use the following line if you will run this inside of a resin container.
export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

#NOTE the network configuration is 
# two ethernet, eth0 and eth1
# two wifi, wlan0 and wlan1
# we are running wifi-connect hotspot on wlan0 so never configure that interface, but that is irrelevant.

# delete all the connections, they are named after the interface
nmcli connection delete eth0 || true
echo "deleted eth0"
nmcli connection delete resin-wifi-01 | true
echo "deleted resin-wifi-01"

nmcli connection add con-name eth0 ifname eth0 type ethernet ip4 192.168.1.199/24 gw4 192.168.1.1
nmcli connection modify eth0 ipv4.dns 8.8.8.8
nmcli connection up eth0
