allcolors() {
	for i in {0..255}; do
		output="$output $(fg-color $i)$i";
	done;
	echo "$output"
}

dudir() { du -scm *(ND) | sort -n }

vimhelp() { vim -c "h $1 | only" }

whois() { command whois "$@" | grep -v "Terms of Use" }
