#!/bin/bash
#https://stackoverflow.com/questions/2237080/how-to-compare-strings-in-bash

i="hello"
if [ "$i" = "hello" ] || [ "$i" = "world" ]
then
   echo $i 
fi
