#!/bin/bash
# Author: oicu@github
[ $# -ne 1 ] && exit 1
[ ! "$PWD" = "/etc/wireguard" ] && exit 1
if [ $1 = "y" ]; then
    umask 077
    mkdir -p /etc/wireguard/{peers,clients}
    server_private_key="$(wg genkey)"
    server_public_key="$(echo $server_private_key | wg pubkey)"
    sed -i -e 's#^PublicKey.*#'PublicKey\ =\ ${server_public_key}'#' client.tpl
    sed -i -e 's#^PrivateKey.*#'PrivateKey\ =\ ${server_private_key}'#' server.tpl
    echo 172.16.0.{2..253} >ipaddrs.txt
    echo 172.16.1.{2..253} >>ipaddrs.txt
    echo 172.16.2.{2..253} >>ipaddrs.txt
    echo 172.16.3.{2..253} >>ipaddrs.txt
    sed -i 's# #\n#g' ipaddrs.txt
    wc -l ipaddrs.txt
    sysctl -w net.ipv4.ip_forward=1
fi
