# https://www.unix.com/shell-programming-and-scripting/148546-shell-assign-variable-another-variable.html
var1=abc
var2=$var1
echo $var2
# https://stackoverflow.com/questions/4651437/how-do-i-set-a-variable-to-the-output-of-a-command-in-bash
var3="$(ls)"
echo $var3
