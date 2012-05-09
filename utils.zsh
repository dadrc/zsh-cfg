function allcolors() {
	for i in {0..255}; do
		output="$output $(fgColor $i)$i";
	done;
	echo "$output"
}

