# vim: set syntax=zsh:

autoload -U add-zsh-hook

setopt prompt_subst

# color setup
if [ $UID -eq 0 ]; then
	NCOLOR="red";
	CCOLOR="red";
else
	NCOLOR="reset_color";
	CCOLOR="green";
fi

add-zsh-hook precmd drc_precmd
function drc_precmd {
	curdir=$(currentdir)
	vcs_info 'prompt'
	gitinfo="${${vcs_info_msg_0_%%.}/$HOME/~}"
}

function currentdir {
	local directory=${PWD/$HOME/"~"}
	local count=$(echo $directory | tr -cd "/" | wc -c)
        if [ $count -gt 3 ]; then
		echo "…/"$(echo $directory | cut -d "/" -f$(($count - 1))-)
	else
		echo $directory
	fi
}

function setprompt {
	PROMPT='%{$fg[$NCOLOR]%}%m%{$reset_color%}:%{$fg[green]%}$curdir%{$reset_color%}:%{$fg[$CCOLOR]%}%(!.#.$)%{$reset_color%} '
	RPROMPT='%(?..!) $gitinfo'
}

setprompt
