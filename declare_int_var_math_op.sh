# https://bash.cyberciti.biz/guide/Create_an_integer_variable
# https://www.tutorialspoint.com/unix/unix-arithmetic-operators.htm
declare -i l=3
echo "l is "${l} #l is 3
echo "l-5 is "`expr ${l} - 5` #l-5 is -2
