#!/bin/bash
# Author: oicu@github
if [ $# -ne 1 ]; then
    echo "usage: $(basename $0) client_host_name"
    exit 1
fi

cd /etc/wireguard/

if [ $(ip link show wg0 2>&1 | grep -c "does not exist") -eq 1 ]; then
    /etc/wireguard/restart.sh
fi

if [ -f peers/${1}.conf ]; then
    echo "peers/${1}.conf is exist."
    exit 1
fi

if [ -s ipaddrs.txt ]; then

    ipaddr=$(head -1 ipaddrs.txt)
    sed -i '1d' ipaddrs.txt

    client_private_key="$(wg genkey)"
    client_public_key="$(echo $client_private_key | wg pubkey)"
    wg set wg0 peer ${client_public_key} allowed-ips ${ipaddr}/32
    sed -e 's#client_public#'${client_public_key}'#'   -e 's#client_ip#'${ipaddr}'#' peer.tpl   > peers/${1}.conf
    sed -e 's#client_private#'${client_private_key}'#' -e 's#client_ip#'${ipaddr}'#' client.tpl > clients/${1}.conf

    qrencode -t ansiutf8 < clients/${1}.conf
    qrencode -t PNG -o clients/${1}.png < clients/${1}.conf

else
    echo "ipaddrs.txt is empty."
    exit 1
fi
