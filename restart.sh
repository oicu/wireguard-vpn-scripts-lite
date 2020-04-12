#!/bin/bash
# Author: oicu@github
wg-quick down wg0
cat server.tpl peers/*.conf > wg0.conf
wg-quick up wg0

