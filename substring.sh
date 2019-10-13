s="hello world"
echo "string1: "
echo ${s} #hello world
echo "its substring, start from index 0, length 5: "${s:0:5} #its substring, start from index 0, length 5: hello
echo "its substring, start from index 6, length 5: "${s:6:5} #its substring, start from index 6, length 5: world

s2="libopencv.so.4.1.2"
echo "string2: "${s2} #string2: libopencv.so.4.1.2 
len=${#s2}
echo "its substring, remove the last 6 character: "${s2:0:`expr ${len} - 6`} #its substring, remove the last 6 character: libopencv.so
