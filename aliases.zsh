alias -g latest='echo *(om[1])'
alias xclip='xclip -selection c'
alias gedit='gedit &>/dev/null'
alias gdebi-gtk='gdebi-gtk &>/dev/null'
alias caffeine='echo -n "Keeping display awake "; while sleep 60; do xdotool keydown Shift_L keyup Shift_L; echo -n "."; done'
alias doch='sudo $(fc -ln -1)'
alias gpuload='nvidia-settings -q ":0/GPUUtilization[gpu:0]" | grep -oP "graphics=\d+" | cut -d= -f2'
alias gputemp='nvidia-settings -q gpucoretemp | grep -oP ": \d+" | cut -d" " -f2'
alias django='python3 manage.py'
alias ip='ip --color'
alias ipb='ip --color --brief'
alias view='vim -R'
alias startvm='VBoxManage startvm --type headless'
alias prime="perl -wle 'print \"prime\" if (1 x shift) !~ /^1?$|^(11+?)\1+$/'"
alias tailf='tail -f'
alias dd='dd status=progress'
alias ip='ip --color'
alias ipb='ip --color --brief'
alias apdate='sudo apt update'
alias apgrade='sudo apt full-upgrade'

function try() {
    until ssh "$@"; do
        sleep 1
    done
}
compdef try='ssh'

function rsplit() {
    if [[ -z "$1" ]] || [[ -z "$2" ]] || [[ -z "$3" ]] || [[ -z "$4" ]]; then
        echo "Usage: rsplit pattern output-file-1 output-file-2 input-file"
        return 1
    fi
    awk "{ if (\$0 ~ /$1/) { print > \"$2\" } else { print > \"$3\" }}" "$4"
}
function today() {
    filename="$HOME/ucware/diary/$(date +%Y-%m-%d).md"
    if [[ ! -f $filename ]]; then
        echo "# $(date +%Y-%m-%d)\n\n* " > $filename
    fi
    vim '+normal G$' $filename
}
