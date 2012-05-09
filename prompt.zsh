# vim: set syntax=zsh:

autoload -U add-zsh-hook

setopt prompt_subst

# color setup
if [ $UID -eq 0 ]; then
	host_color=$(fgColor 1);
	prompt_color=$(fgColor 1);
else
	host_color="";
	prompt_color=$(fgColor 33);
fi

path_color=$(fgColor 33)

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
	PROMPT='%{$host_color%}%m%{$reset_color%}:%{$path_color%}$curdir%{$reset_color%}:%{$prompt_color%}%(!.#.$)%{$reset_color%} '
	RPROMPT='%(?..!) $gitinfo'
}

setprompt
