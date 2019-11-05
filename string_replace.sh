#!/bin/bash
str1="hello, goodbye, and hello"
echo "original string: "$str1
str2=${str1/hello/goodbye}
echo "replace first hello with goodbye: "$str2
str3=${str1//hello/goodbye}
echo "replace all hello with goodbye: "$str3

# Result:
# original string: hello, goodbye, and hello
# replace first hello with goodbye: goodbye, goodbye, and hello
# replace all hello with goodbye: goodbye, goodbye, and goodbye
