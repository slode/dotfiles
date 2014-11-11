# wunjo prompt theme

function coloratom() {
	local off=$1 atom=$2
	if [[ $atom[1] == [[:upper:]] ]]; then
		off=$(( $off + 60 ))
	fi
	echo $(( $off + $colorcode[${(L)atom}] ))
}

function colorword() {
	local fg=$1 bg=$2 att=$3
	local -a s

	if [ -n "$fg" ]; then
		s+=$(coloratom 30 $fg)
	fi
	if [ -n "$bg" ]; then
		s+=$(coloratom 40 $bg)
	fi
	if [ -n "$att" ]; then
		s+=$attcode[$att]
	fi

	echo "%{"$'\e['${(j:;:)s}m"%}"
}

function reset() {
  echo $(colorword . . 00)
}

typeset -A colorcode
colorcode[black]=0
colorcode[red]=1
colorcode[green]=2
colorcode[yellow]=3
colorcode[blue]=4
colorcode[magenta]=5
colorcode[cyan]=6
colorcode[white]=7
colorcode[default]=9
colorcode[k]=$colorcode[black]
colorcode[r]=$colorcode[red]
colorcode[g]=$colorcode[green]
colorcode[y]=$colorcode[yellow]
colorcode[b]=$colorcode[blue]
colorcode[m]=$colorcode[magenta]
colorcode[c]=$colorcode[cyan]
colorcode[w]=$colorcode[white]
colorcode[.]=$colorcode[default]

typeset -A attcode
attcode[none]=00
attcode[bold]=01
attcode[faint]=02
attcode[standout]=03
attcode[underline]=04
attcode[blink]=05
attcode[reverse]=07
attcode[conceal]=08
attcode[normal]=22
attcode[no-standout]=23
attcode[no-underline]=24
attcode[no-blink]=25
attcode[no-reverse]=27
attcode[no-conceal]=28
