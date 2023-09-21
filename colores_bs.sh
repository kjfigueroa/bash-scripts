#!/bin/bash

for i in $(seq 200); do
	echo -e "\e[$(echo $i)m text in $i \e[0m"
done
