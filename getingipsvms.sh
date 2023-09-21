#!/usr/bin/bash
#Defining IPs for virtualbox machines
# By Kevin J. Figueroa

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
	
}
# End Sending

interface="$(ip link show |grep 'state UP' |awk '{print $2}'|sed 's/://g')"

if [ $? == 0 ]; then
	gatewayadd="$(ip addr |grep -E "inet.*$interface" |awk '{print $2}' |cut -d / -f 1|sed 's/\./ /g' |awk '{print $1"."$2"."$3".0/24"}')"
        if [ $? == 0 ]; then
		scanner="$(nmap -sn "$gatewayadd" > /dev/null 2>&1)" & spinProgress		
                if [ $? == 0 ]; then
			c1VM="$(ip neigh |grep -Ei "08.*00.*27.*D7.*BB.*43" |awk '{print $1}')"
			if [[ $c1VM != '' ]]; then
				numcen1="$(sudo grep -n centos1vm /etc/hosts |cut -d : -f 1)"
				#echo "$numcen1 $c1VM"
				sudo sed -i "$(echo $numcen1)s/\.`*`/$c1VM centos1/g" /etc/hosts 2>/dev/null
          			echo "Written the host for VM Centos1" 2>/dev/null
 			else
          			echo "empty. VM Centos1 is OFF"
  			fi
			c2VM="$(ip neigh |grep -Ei "08.*00.*27.*01.*26.*03" |awk '{print $1}')"
			if [[ $c2VM != '' ]]; then
				numcen2="$(sudo grep -n centos2vm /etc/hosts |cut -d : -f 1)"
				#echo "$numcen2 $c2VM"
				sudo sed -i "$(echo $numcen2)s/\.`*`/$c2VM centos2/g" /etc/hosts 2>/dev/null
          			echo "Written the host for VM Centos2" 2>/dev/null
			else
        			echo "empty. VM Centos2 is OFF"
			fi
			uVM="$(ip neigh |grep -Ei "08.*00.*27.*e6.*6d.*20" |awk '{print $1}')"
			if [[ $uVM != '' ]]; then
				numubu="$(sudo grep -n ubuntuvm /etc/hosts |cut -d : -f 1)"
				#echo "$numubu $uVM"
				sudo sed -i "$(echo $numubu)s/\.`*`/$uVM ubuntu/g" /etc/hosts 2>/dev/null
          			echo "Written the host for VM Ubuntu" 2>/dev/null
			else
         			echo "empty. VM Ubuntu is OFF"
			fi

               fi
        fi
fi

exit 0
