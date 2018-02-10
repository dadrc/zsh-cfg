allcolors() {
	for i in {0..255}; do
		output="$output $(fg-color $i)$i";
	done;
	echo "$output"
}

dudir() { du -scm *(ND) | sort -n }

whois() { command whois "$@" | grep -v "Terms of Use" }

randline() {
    integer z=$(wc -l <$1)
    sed -n $[RANDOM % z + 1]p $1
}
