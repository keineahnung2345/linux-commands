#!/bin/bash
# https://unix.stackexchange.com/questions/47584/in-a-bash-script-using-the-conditional-or-in-an-if-statement

for i in 1 2 3 4 5 6
do
    #if [ "$i" -lt 3 ] || [ "$i" -gt 5 ]; then
    if [ "$i" -gt 3 ] && [ "$i" -lt 5 ]; then
        continue
    fi
    echo $i
done
