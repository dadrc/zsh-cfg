allcolors() {
	for i in {0..255}; do
		output="$output $(fg-color $i)$i";
	done;
	echo "$output"
}

dudir() {
  du -scm *(ND) | sort -n
}

whois() {
  command whois "$@" | grep -v "Terms of Use"
}

randline() {
    integer z=$(wc -l <$1)
    sed -n $[RANDOM % z + 1]p $1
}

ppgrep() {
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
}

ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
}
