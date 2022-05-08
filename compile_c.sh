#!/usr/bin/env bash

[[ $1 =~ ([a-zA-Z0-9_]+).c ]] # $pat must be unquoted
#echo "${BASH_REMATCH[0]}" # File name with ".c"
#echo "${BASH_REMATCH[1]}" # File name without ".c"
filename=${BASH_REMATCH[1]}

gcc -Wall -Wextra -Werror -ggdb -o ./$filename ./$filename.c

./$filename

rm ./$filename
