DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome pushd_ignore_dups
alias dh='dirs -v'
alias cr='cd -"$(dirs -v | rofi -dmenu | cut -f1 )"'
