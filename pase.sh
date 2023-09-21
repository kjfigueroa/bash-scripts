#!/usr/bin/bash

if [ -z "$1" ]
then
	export clave="$1"
	echo "$(echo $clave)"

else
	echo "$(echo $clave)"
fi
