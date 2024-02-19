#!/bin/bash
#
# By Kevin J. Figueroa M. https://github.com/kjfigueroa
#
# configuring static addressing for a virtual machine (Ubuntu)

func(){
        interf="$(ip route |grep default |awk '{print $5}')"
        echo -e "\n------------------------------"
        echo "default interface: $interf"
        checkNetcfg
}

checkNetcfg(){
        sleep 0.33
        dpkg-query -W |grep netplan >/dev/null
        if [[ $? -eq "0" ]]; then
                echo "packages necessary to configure netplan are installed, the configuration begins..."
                sleep 0.33;
                netCfg
        else
                read -p "This machine does not have netplan installed, do you want to install it? [Y/N]" yn
                if [[ "$yn" == "Y" ]] || [[ "$yn" == "y" ]]; then
                        apt-get install -y netplan.io libnetplan
                        netCfg
                elif [[ "$yn" == "N" ]] || [[ "$yn" == "n" ]]; then
                        echo "The following packages are currently required to continue"
                        echo "netplan.io libnetplan"
                        exit 0
                else
                        echo "type [Y/N]"; checkNetcfg
                fi
        fi
}

netCfg(){
mkdir -p /etc/netplan
rdefault="$(ip route |grep default |awk '{print $5}')"
range="$(ip route |grep -v default |grep $rdefault |awk '{print $1}')"
gat4="$(ip route |grep default |awk '{print $3}')"
read -p "Type a proper IP fo the host, which is in the range [$range]: " ipadr
cat <<EOF | tee /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    $interf:
      dhcp4: no
      gateway4: [$gat4]
      adresses: [$ipadr/24]
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
EOF
netApply
echo -e "The netplan above is about to config"
}

netApply(){
read -p "Continue... [Y/N]: " ans
if [[ "$ans" == "Y" ]] || [[ "$ans" == "y" ]];then
        #netplan apply
        echo -e "\n-------New netplan applied-------\n"
        ip address show $rdefault
        echo ""
        exit 0
elif [[ "$ans" == "N" ]] || [[ "$ans" == "n" ]]; then
        rm -f /etc/netplan/01-netcfg.yaml
        exit 0
else
        echo "type Y/N"
        sleep 0.33
        netApply
fi
}

read -p "run (apt update) [Y/N]: " select
if [[ "$select" == "Y" ]] || [[ "$select" == "y" ]]; then
        apt-get update
        func
else
        func
fi