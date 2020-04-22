#!/bin/bash
# Author: oicu@github
line="$(ls peers/*.conf 2>/dev/null | wc -l)"
if [ $line -eq 0 ]; then
    echo "Not found any user.conf"
    exit 1
fi

list=$(grep "172.16.0.*24" clients/*.conf 2>/dev/null | \
    sed -e "s#clients/##g" \
        -e "s#.conf:Address = #\t#g" \
        -e "s#/24##g" | \
    awk '{print $2,"\t",$1}' | \
    sort -n -t "." -k 4)

if [ "$1" = "-v" ]; then
    file="$(wg | sed -e '/^peer/d' -e '/endpoint/d' -e 's#/32##' -e 's#allowed ips: ##')"
    icount=0
    echo "$list" | \
    while read IP USER; do
        let icount++
        file=$(echo "$file" | sed 's#'$IP'#'$IP'\t'$USER'#g')
        [ $icount = $line ] && echo "$file"
    done
else
    echo "$list"
fi
