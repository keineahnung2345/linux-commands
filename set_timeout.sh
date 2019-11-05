#! /bin/bash

# https://stackoverflow.com/questions/43533054/aborting-a-script-if-any-command-takes-too-long-to-run

echo "set timeout as 2 secs"
echo "sleep 1"
timeout 2 time sleep 1
echo "exit status: "$?
if [[ $? == 124 ]]
then
    echo "exit"
    exit;
fi

echo "sleep 3"
timeout 2 time sleep 3
#if [[ $? == 124 ]]
echo "exit status: "$?
if [[ $? != 0 ]]
then
    echo "exit"
    exit;
fi
