highlight=$(which highlight)
#export LESSOPEN="| $highlight %s --out-format xterm256 --quiet --force --style solarized-light"
export LESS=" -R"
alias less='less -m -N -g -i -J --underline-special'
alias more='less'

#alias ccat="$highlight $1 --out-format xterm256 --quiet --force --style solarized-light"

