#!/bin/bash

configs_path="/home/salus/.config/wg-interfaces"
connected_interface=$(networkctl | grep -P "\d+ .* wireguard routable" -o | cut -d " " -f 2)

connect() {
	selected_config=$(ls $configs_path | xargs basename -a -s .conf | dmenu)
	[[ $selected_config ]] && sudo wg-quick up "$configs_path"/"$selected_config".conf
}

disconnect() {
	for connected_config in $(networkctl | grep -P "\d+ .* wireguard routable" -o | cut -d " " -f 2)
	do
		sudo wg-quick down $configs_path/"$connected_config".conf
	done
}

toggle() {
	if [[ $connected_interface ]]
	then
		disconnect
	else
		connect
	fi
}

print() {
	if [[ $connected_interface ]]
	then
		echo "$connected_interface"
	else
		echo "no vpn"
	fi
}

case "$1" in 
	--connect)
		connect
		;;
	--disconnect)
		disconnect
		;;
	--toggle)
		toggle
		;;
	*)
		print
		;;
esac
