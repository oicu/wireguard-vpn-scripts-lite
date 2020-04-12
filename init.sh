#!/bin/bash
# Author: oicu@github
server_private_key="$(wg genkey)"
server_public_key="$(echo $server_private_key | wg pubkey)"
sed -i -e 's#^PublicKey.*#'PublicKey\ =\ ${server_public_key}'#' client.tpl
sed -i -e 's#^PrivateKey.*#'PrivateKey\ =\ ${server_private_key}'#' server.tpl
