# vim: set syntax=zsh:

autoload -U add-zsh-hook

TRAPUSR1() { rehash };

add-zsh-hook precmd apt-hook-precmd
function apt-hook-precmd() {[[ $history[$[ HISTCMD -1 ]] == *(apt-get|aptitude)* ]] && killall -USR1 zsh }
