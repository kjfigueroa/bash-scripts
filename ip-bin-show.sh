#!/bin/bash
var=$1

for i in 1 2 3 4; do
        mkdir -p /tmp/ip-bins
        echo "$var" | cut -d . -f $i > /tmp/ip-bins/oc_$i
        printf "%08d\n" $(echo -e "obase=2; $(cat /tmp/ip-bins/oc_$i)" | bc)
done
rm -rf /tmp/ip-bins/
