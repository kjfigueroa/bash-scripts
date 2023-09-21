#!/usr/bin/bash
#Defining IPs for virtualbox machines
# By Kevin J. Figueroa

# Hosts Flags
Nu="3"
F1="centos1vm"
F2="centos1vm"
F3="ubuntuvm"
MCen1="08.*00.*27.*D7.*BB.*43"
MCen2="08.*00.*27.*01.*26.*03"
MCen3="08.*00.*27.*A7.*EB.*74"
MUb="08.*00.*27.*e6.*6d.*20"

# Indicator
 spinProgress()
 {
     local pid=$!
     local delay=0.75
     local spinstr='|/-\'
     while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
         local temp=${spinstr#?}
         printf " %c  " "$spinstr"
         local spinstr=$temp${spinstr%"$temp"}
         sleep $delay
         printf "\b\b\b\b\b\b"
     done
     printf "    \b\b\b\b"
 }
# End: Indicator

# Sending the lines 
write(){
    #sudo sed -i "$(echo $1)s/\.*/$(echo $2 $3)/g" /etc/hosts 2>/dev/null
    #for i in $(seq 1); do
        sudo sed --in-place ""$1"s/\0\.*\0/\0$2 $3\0/g" "/etc/hosts" |uniq -u 2>/dev/null
        #awk "{ if ( "$3" == "Author" ) {$2="technical author"} print $0}"
        echo "Written the host for VM $(echo $3)" 2>/dev/null
    #done
}
# End Sending

getip(){
    for i in $Nu; do
        IVM="$(ip neigh |grep -Ei "$MCen1" |awk '{print $1}')"
    done
}

interface="$(ip link show |grep 'state UP' |awk '{print $2}'|sed 's/://g')"
gatewayadd="$(ip addr |grep -E "inet.*$interface" |awk '{print $2}' |cut -d / -f 1|sed 's/\./ /g' |awk '{print $1"."$2"."$3".0/24"}')"
scanner="$(nmap -sn "$gatewayadd" > /dev/null 2>&1)" & spinProgress		
numcen1="$(sudo grep -n $(echo $F1) /etc/hosts |cut -d : -f 1)"
numcen2="$(sudo grep -n $(echo $F2) /etc/hosts |cut -d : -f 1)"
numubu="$(sudo grep -n $(echo $F3) /etc/hosts |cut -d : -f 1)"

c1VM="$(ip neigh |grep -Ei "$MCen1" |awk '{print $1}')"
if [[ $c1VM == '' ]]; then
    echo "empty. VM Centos1 is OFF"
else
    write $numcen1 $c1VM $F1
fi
c2VM="$(ip neigh |grep -Ei "$MCen2" |awk '{print $1}')"
if [[ $c2VM == '' ]]; then
    echo "empty. VM Centos2 is OFF"
else
    write $numcen2 $c2VM $F2
fi

uVM="$(ip neigh |grep -Ei "$MUb" |awk '{print $1}')"
if [[ $uVM == '' ]]; then
    echo "empty. VM Ubuntu is OFF"
else
    write $numubu $uVM $F3
fi

exit 0
