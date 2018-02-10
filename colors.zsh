function fg-color() {
	if [[ $1 == <0-255> ]]; then
		echo "\x1b[38;5;${1}m"
	fi
}


function bg-color() {
	if [[ $1 == <0-255> ]]; then
		echo "\x1b[48;5;${1}m"
	fi
}
