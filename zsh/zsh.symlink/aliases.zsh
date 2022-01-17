alias 'as=apt-cache search'
alias 'aw=apt-cache show'

alias ggl="ping www.google.com"
alias sl="ls -Fh --color=auto" # --sort=extension" 
alias lsl="ls -Flah --color=auto" # --sort=extension" 
alias lse="ls -Flah --color=auto --sort=extension" 
alias ls="ls -Fh --color=auto" # --sort=extension" 
alias lsa="ls -Fah --color=auto" # --sort=extension" 
alias lsd="ls -lah --color=auto -d */"

alias dudir="du -xch --max-depth=0 *"

alias xml="xmllint --format "

alias grep="grep --color"
alias mv="mv -vi"
alias cp="cp -vi"
alias h="history | grep -i"
alias xx="exit"

export EDITOR=nvim
alias vim="$EDITOR"
alias vec="vim $(git status --porcelain | awk '{print $2}')"

fe() {
  find . -iname "*$@"
}
fs() {
  find . -iname "$@*"
}
ff() {
  find . -iname "*$@*"
}

alias tmux="TERM=screen-256color tmux -2"

#TERM=${TERM || TERM == "dumb"?"xterm-256color"}
#export TERM

alias pp='python -c "import sys, json; print json.dumps( json.load(sys.stdin), sort_keys=True, indent=4)"'

all-git() {
  for i in */.git; do
    gitdir=$(dirname $i);
    echo $fg[green]">>> repos="$gitdir $reset_color
    (cd $gitdir && git $@)
    echo ""
  done
}

svp() {
  for s in $SVDIR/$2*; do
    echo "${fg[yellow]}>>> sv ${1} ${s}${reset_color}"
    outp=$(sv $1 $s)
    if [ $? -ne 0 ]; then
      echo "${fg[red]}${outp}${reset_color}"
    else
      echo "${fg[green]}${outp}${reset_color}"
    fi
  done
}

LOGDIR=~/log/services
mult() {
  LOGFILES=$(find $LOGDIR -iname "current")
  if [ ! -z $1 ]; then
    LOGFILES=$(echo $LOGFILES | grep $1)
  fi
  multitail -s 2 -M 10000 -N 10000 --follow-all -CS runit $(echo $LOGFILES)
}


