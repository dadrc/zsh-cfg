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

function currentdir {
    local -a arr
    if [[ $PWD == $HOME* ]]; then             # if we are in a directory within our homedir.
        arr=( ${(s:/:)${PWD/$HOME\/#/\~/}} )    # substitute our homedir with ~/, then split the result into a array
        arr[2,-2]=(${(M)arr[2,-2]#?})           # for every element besides 1(~/) and the last, truncate the word to one letter.
    else
        arr=( ${(s:/:)PWD} )                    # we aren't in homedir, so just split PWD as-is
        arr[0,-2]=('' ${(M)arr[1,-2]#?})        # truncation of every directory component except the last one, also add new zero length string
    fi
    echo ${${(j:/:)arr}:-/}               # assign our string to psvar[1] so we can use %1v in PS1.
                                    # joining(j:/:) our array delimited by /, the zero length string ensures the first / is added back.
                                    # ${...:-/} is for a corner case, when we are in /.
}

function setprompt {
	PROMPT='%{$host_color%}%m%{$reset_color%}:%{$path_color%}$curdir%{$reset_color%}:%{$prompt_color%}%(!.#.$)%{$reset_color%} '
	RPROMPT='%(?..%{$(fg-color 1)%}!%{$reset_color%}) $gitinfo'
}

setprompt
