zmodload zsh/terminfo

typeset -gA keys

key=(
    'Ctrl'                '\C-'
    'CtrlLeft'            "$terminfo[kLFT5]"
    'CtrlRight'           "$terminfo[kRIT5]"
    'CtrlUp'              "$terminfo[kUP5]"
    'CtrlDown'            "$terminfo[kDN5]"
    'CtrlBackspace'       "$terminfo[cub1]"
    'Backspace'           "$terminfo[kbs]"
    'Delete'              "$terminfo[kdch1]"
    'F1'                  "$terminfo[kf1]"
    'F2'                  "$terminfo[kf2]"
    'F3'                  "$terminfo[kf3]"
    'F4'                  "$terminfo[kf4]"
    'F5'                  "$terminfo[kf5]"
    'F6'                  "$terminfo[kf6]"
    'F7'                  "$terminfo[kf7]"
    'F8'                  "$terminfo[kf8]"
    'F9'                  "$terminfo[kf9]"
    'F10'                 "$terminfo[kf10]"
    'F11'                 "$terminfo[kf11]"
    'F12'                 "$terminfo[kf12]"
    'Insert'              "$terminfo[kich1]"
    'Home'                "$terminfo[khome]"
    'PageUp'              "$terminfo[kpp]"
    'End'                 "$terminfo[kend]"
    'PageDown'            "$terminfo[knp]"
    'Up'                  "$terminfo[kcuu1]"
    'Left'                "$terminfo[kcub1]"
    'Down'                "$terminfo[kcud1]"
    'Right'               "$terminfo[kcuf1]"
    'Tab'                 "$terminfo[kctab]"
    'BackTab'             "$terminfo[kcbt]"
)

if echoti smkx >&/dev/null; then
  # Finally, make sure the terminal is in application mode, when zle is
  # active. Only then are the values from $terminfo valid.
  function zle-line-init () {
    echoti smkx
  }
  function zle-line-finish () {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi
