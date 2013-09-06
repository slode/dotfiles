alias 'as=apt-cache search'
alias 'aw=apt-cache show'

alias ggl="ping www.google.com"
alias sl="ls -Fh --color=auto --sort=extension" 
alias lsl="ls -Flah --color=auto --sort=extension" 
alias ls="ls -Fh --color=auto --sort=extension" 
alias lsa="ls -Fah --color=auto --sort=extension" 
alias lsd="ls -lah --color=auto -d */"

alias dudir="du -xch --max-depth=0 *"

alias xml="xmllint --format "

alias grep="grep --color"
alias less="less -r"
alias more="less -r"
alias mv="mv -vi"
alias cp="cp -vi"
alias h="history | grep -i"
alias xx="exit"

ff() {
  exec find . -iname '$*'
}


alias tmux="TERM=screen-256color tmux -2"

#TERM=${TERM || TERM == "dumb"?"xterm-256color"}
#export TERM

alias pp='python -c "import sys, json; print json.dumps( json.load(sys.stdin), sort_keys=True, indent=4)"'

