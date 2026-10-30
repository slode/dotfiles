
LOGDIR=~/log/services
FILTER_FILE=~/.log_filter


open-log() {
  file=$1
  shift
  title=$(echo $file| cut -d'/' -f6- | cut -d'/' -f-1)
  gnome-terminal --title="$title" -- sh -c "tail -n 5000 -F \"$file\" | sed -f $FILTER_FILE | LESS='-SR' hl -P $*" &
}

find-log-files() {
  local LOGFILES=()
  for ptrn in "${preceding_args[@]:-}"; do
    for s in ${LOGDIR}/($ptrn|*.$ptrn)*/current; do
      LOGFILES+=("$s")
    done
  done
  echo "${LOGFILES[@]}"
}

i3-log-view() {
  setopt null_glob

  preceding_args=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --)
        shift
        break # Stop collecting once we hit the double-dash
        ;;
      *)
        preceding_args+=("$1") # Add to our list
        shift
        ;;
    esac
  done

  local log_files=( $(find-log-files "$preceding_args[@]") )

  i3-msg split v > /dev/null
  i3-msg layout tabbed > /dev/null
  for f in $log_files; do
    open-log $f $@
    disown
  done
  # exit
}

alias lll="i3-log-view"
