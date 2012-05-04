if [ $UID -eq 0 ]; then
	NCOLOR="red";
	CCOLOR="red";
else
	NCOLOR="reset_color";
	CCOLOR="green";
fi

# this one works, too, but ~ uses shortcuts, which looks ugly
#function currentdir {
#	local directory=${(%):-%~}
#	local count=$(echo $directory | tr -cd "/" | wc -c)
#	if [ $count -gt 3 ]; then
#		echo "…/"%3~
#	else
#		echo %~
#	fi
#}

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
RPROMPT='%{$fg[green]%}$(git_prompt_info)%{$reset_color%}%'

ZSH_THEME_GIT_PROMPT_PREFIX="<%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}✗%{$fg[green]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}>"
