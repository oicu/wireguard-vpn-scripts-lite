#!/bin/bash
# Author: oicu@github
client_host_name=$(basename $1)
client_public_key=$(cat peers/${client_host_name} | perl -ne 'print $1 if /PublicKey\s*=\s*(.*)/')
wg set wg0 peer ${client_public_key} remove
rm -f peers/${client_host_name}
rm -f clients/${client_host_name}

