function allcolors() {
	for i in {0..255}; do
		output="$output $(fg-color $i)$i";
	done;
	echo "$output"
}

function dudir() { du -scm *(ND) | sort -n }
