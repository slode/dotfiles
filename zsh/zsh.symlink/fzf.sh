# Setup fzf
# ---------
if [[ ! "$PATH" == */home/stian/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/stian/.fzf/bin"
fi

source <(fzf --zsh)
