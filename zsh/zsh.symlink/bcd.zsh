#
# Written by Florian Diesch <devel@florian-diesch.de> 
#
# Updates may be available at
# <http://www.florian-diesch-.de/software/shell-scripts/> 
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
# You are free to do with it what ever you want.
#



BCDRC_FILE=~/.bcdrc

_bcd_check_cfg_file(){
  if [ -e "$BCDRC_FILE" ]; then
      true
  else
      printf "\nFile '$BCDRC_FILE' not found.\n"
      false
  fi
}

_bcd_help(){
    if _bcd_check_cfg_file; then
	_IFS="$IFS"
	IFS=":"
	while read k v; do 
	    [ -z "$k" ] || printf '% 10s --> %s\n' "$k" "$v"; 
	done < "$BCDRC_FILE"
	IFS="$_IFS"
    fi
}

## Go to a bookmark
bcd(){
 if [ $# -eq 0 ]; then
     _bcd_help
 elif  _bcd_check_cfg_file; then
   dir="$(grep "^$1:" "$BCDRC_FILE" | cut -d: -f2-|head -n1)"
   if [ -z "$dir" ]; then 
     echo "No bookmark \"$1\""
   else
     cd "$dir"
   fi
 fi
}

## Add a bookmark
bcdadd(){
    name="${1:-}"
    dir="${2:-$PWD}"
    if [ $# -eq 0 ];  then
	printf "Bookmark name: "; read name
    fi
    if [ ! -d "$(dirname  "$BCDRC_FILE")" ]; then
	mkdir -p "$(dirname  "$BCDRC_FILE")"
    fi
    touch "$BCDRC_FILE"
    if ! grep -q "^$name:" "$BCDRC_FILE"; then
	echo "Adding bookmark '$name' for '$dir'"
	echo "$name:$dir" >> "$BCDRC_FILE"
    else
	echo "Error: Bookmark '$name' already defined"
    fi
}

## Remove a bookmark
bcddel(){
    name="${1:-}"
    if [ $# -eq 0 ];  then
	name=
    fi
    if [ -e "$BCDRC_FILE" ]; then
	sed -i -e "/^$name:/ d" "$BCDRC_FILE"
	echo "Removed bookmark '$name'"
    else
	echo "File '$BCDRC_FILE' not found. Bookmark not removed"
    fi
}

## Show bookmarks for dir
bcdq(){
    name="${1:-$PWD}"
    if _bcd_check_cfg_file; then
	grep  ":$name\$" "$BCDRC_FILE" | cut -d: -f1| grep . || \
	    echo "No bookmark for '$name' found"
    fi

}

# list all bookmark names
bcdlist(){
    if _bcd_check_cfg_file; then
        _IFS="$IFS"
        IFS=":"
        grep "^$1" "$BCDRC_FILE" | sort | while read k v; do 
            [ -z "$k" ] || printf "$k\n"
        done 
        IFS="$_IFS"
    fi
}


##############################################################
##
##   Remove the rest of the file if you don't use Bash or Zsh
##   otherwise you may get syntax errors
##
##############################################################

if [ -n "$BASH" ] ; then

###
### Bash completion
###


    _bcd_bash_completion(){
	local cur prev i
	
	COMPREPLY=()
	_get_comp_words_by_ref cur prev
	i=$COMP_CWORD
	_expand || return 0
	
	COMPREPLY=( $(bcdlist "$cur" ) )
    }

    complete -F _bcd_bash_completion bcd bcddel


elif [ -n "$ZSH_VERSION" ] ; then

###
### zsh completion
###



    _bcd_list(){
	_IFS="$IFS"
	IFS=$(printf '\n')
	reply=($(for p in $*; do
		_bcd_help|grep "^ *$p "
		done))
	IFS="$_IFS" 
    }
    
    _bcd() {
	if _bcd_check_cfg_file; then
	    reply=($(cut -d: -f1 "$BCDRC_FILE"|tr '\n' ' '|sort))
	fi
    }
    compctl -K _bcd -y _bcd_list -X 'Completing bcd bookmarks' bcd
    compctl -K _bcd -y _bcd_list -X 'Completing bcd bookmarks' bcddel
    compctl -/ bcdq


fi
# Local Variables:
# mode: sh
# End:
