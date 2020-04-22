#!/bin/bash
# Author: oicu@github
if [ $# -ne 1 ]; then
    echo "usage: $(basename $0) peers/client_host_name.conf"
    exit 1
fi
client_host_name=$(basename $1)

cd /etc/wireguard/

if [ $(ip link show wg0 2>&1 | grep -c "does not exist") -eq 1 ]; then
    /etc/wireguard/restart.sh
fi

if [ -s peers/${client_host_name} ]; then
    client_public_key=$(cat peers/${client_host_name} | perl -ne 'print $1 if /PublicKey\s*=\s*(.*)/')
    ipaddr=$(cat peers/${client_host_name} | perl -ne 'print $1 if /AllowedIPs\s*=\s*(.*)/')
    echo $client_public_key $ipaddr
    wg set wg0 peer ${client_public_key} remove
    rm -f peers/${client_host_name}
    rm -f clients/${client_host_name}
    rm -f clients/${client_host_name/\.conf/}.png
    echo ${ipaddr/\/32/}>>ipaddrs.txt
else
    echo "peers/${client_host_name} is not found."
    exit 1
fi
