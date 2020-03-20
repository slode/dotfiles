zmodload zsh/terminfo

typeset -gA keys

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  source ~/.zsh/terminfo.zsh.inc
else
  source ~/.zsh/zkbd.zsh.inc
fi

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-search #history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-search #history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" history-beginning-search-forward
[[ -n "${key[Backspace]}" ]]  && bindkey  "${key[Backspace]}" backward-delete-char

[[ -n "${key[CtrlLeft]}"         ]]  && bindkey  "${key[CtrlLeft]}"        backward-word
[[ -n "${key[CtrlRight]}"        ]]  && bindkey  "${key[CtrlRight]}"       forward-word
[[ -n "${key[CtrlBackspace]}"    ]]  && bindkey  "${key[CtrlBackspace]}"   backward-delete-word

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[CtrlUp]"   ]] && bindkey "$key[CtrlUp]"   up-line-or-beginning-search
[[ -n "$key[CtrlDown]" ]] && bindkey "$key[CtrlDown]" down-line-or-beginning-search

bindkey '^R' history-incremental-pattern-search-backward
