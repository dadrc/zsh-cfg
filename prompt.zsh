export DONTSETRPROMPT=1

if [ $UID -eq 0 ]; then
	NCOLOR="red";
	CCOLOR="red";
else
	NCOLOR="reset_color";
	CCOLOR="green";
fi

function currentdir {
	local directory=${PWD/$HOME/"~"}
	local count=$(echo $directory | tr -cd "/" | wc -c)
        if [ $count -gt 3 ]; then
		echo "…/"$(echo $directory | cut -d "/" -f$(($count - 1))-)
	else
		echo $directory
	fi
}

PROMPT='%{$fg[$NCOLOR]%}%m%{$reset_color%}:%{$fg[green]%}$(currentdir)%{$reset_color%}:%{$fg[$CCOLOR]%}%(!.#.$)%{$reset_color%} '
RPROMPT='%(?..!) ${vcs_info_msg_0_}'
