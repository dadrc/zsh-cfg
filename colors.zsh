function fg-color() {
	if [[ -n $1 ]]; then
		if [[ $1 == <0-255> ]]; then
			echo "\x1b[38;5;${1}m"
		fi
	fi
}


function bg-color() {
	if [[ -n $1 ]]; then
		if [[ $1 == <0-255> ]]; then
			echo "\x1b[48;5;${1}m"
		fi
	fi
}
