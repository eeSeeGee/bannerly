## Bannerly
Makes a sweet slack emoji banner.

If you're a true blue nerd here's how you do it with one line:

`
l=1; figlet -f banner "bannerly" | tr ' ' '_' |  while read LINE; do echo $LINE | sed 's/\(.\)\(.\)\(.\)/\1'$l'1\2'$l'2\3'$l'3/g' | sed 's/\([#_]\)\([#_]\)$/\1'$l'1\2'$l'2/g' | sed 's/\([#_]\)$/\1'$l'1/g'; l=$(($l % 3 + 1)); done | sed 's/#../:partyparrot:/g' | sed 's/_\(..\)/:cash\1:/g' | pbcopy
`

