#!/bin/bash

input=$1
# 9x9, change to set different
code="int puzzle[9][9]={"


function text2c () {
	text=$1
	row="{"
	for (( i=0;i<${#text}; i++ )); do
		char="${text:$i:1}"
		row+="$char,"
	done
	row=$(echo ${row%,*} ${row##*,})
	row+="},"
	code=$code$row
}


while read -r line
do
	if [[ ! -z "$line" ]]; then
		text2c $(echo "$line" | sed 's/ //g')
	fi
done < "$input"

code=$(echo ${code%,*} ${code##*,})
code+="};"

echo $code | sed 's/x/0/g'


