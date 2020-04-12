#!/bin/bash
# Author: oicu@github
if [ $# -ne 2 ]; then
    echo "$(basename $0) client_host_name 172.16.1.[2-254]"
    exit 1
fi
client_private_key="$(wg genkey)"
client_public_key="$(echo $client_private_key | wg pubkey)"
wg set wg0 peer ${client_public_key} allowed-ips ${2}/32
sed -e 's#client_public#'${client_public_key}'#'   -e 's#client_ip#'${2}'#' peer.tpl   > peers/${1}.conf
sed -e 's#client_private#'${client_private_key}'#' -e 's#client_ip#'${2}'#' client.tpl > clients/${1}.conf

