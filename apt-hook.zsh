# vim: set syntax=zsh:

# automatically rehashes all running zsh instances after installing new packages

autoload -U add-zsh-hook

TRAPUSR1() { rehash };

add-zsh-hook precmd apt-hook-precmd
function apt-hook-precmd() {[[ $history[$[ HISTCMD -1 ]] == *(apt|apt-get|aptitude)* ]] && killall --user $USER --signal USR1 zsh }
