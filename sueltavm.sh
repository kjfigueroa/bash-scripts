#!/usr/bin/bash

virtualboxvm --startvm Ubuntu-18.04 & sleep 15; wmctrl -r "Ubuntu-18.04" -e "0,10,64,331,130"
if [ $? == 0 ]; then
        interface=`ip link show |grep 'state UP' |awk '{print $2}'|sed 's/://g'`
        if [ $? == 0 ]; then
                gatewayadd=`ip addr |grep -E "inet.*$interface" |awk '{print $2}' |cut -d / -f 1|sed 's/\./ /g' |awk '{print $1"."$2"."$3".0/24"}'`
                if [ $? == 0 ]; then
                        scanner=`nmap -sn "$gatewayadd" > /dev/null 2>&1`
                        if [ $? == 0 ]; then
                                dev=`arp -n |grep -E "08.*00.*27.*e6.*6d.*20" |awk '{print $1}'`
                                if [ $? == 0  ]; then
                                        terminator -T Ubuntu-18.04 --command="ssh nitro@$dev" &
                                fi
                        fi
                fi
        fi
fi
