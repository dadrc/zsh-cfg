# vim: set syntax=zsh:

autoload -U add-zsh-hook
autoload -U colors && colors

setopt prompt_subst

function hash-to-code() {
	local hosthash=$[0x$(echo "$HOST"|sha1sum|cut -c 26-40)]
	echo $[$hosthash % 209 + 22]
}

# color setup
if [[ $UID -eq 0 ]]; then
	prompt_color=$(fg-color 1);
else
	prompt_color=$(fg-color 33);
fi
path_color=$(fg-color 33)
host_color=$(fg-color $(hash-to-code))

add-zsh-hook precmd prompt-precmd
function prompt-precmd() {
	curdir=$(currentdir)
	vcs_info 'prompt'
	gitinfo="${${vcs_info_msg_0_%%.}/$HOME/~}"
}

function currentdir() {
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
	RPROMPT='%(?..%{$(fg-color 1)%}!%{$reset_color%}) $gitinfo'
}

setprompt
