#!/bin/bash
# list_of_dirs.txt is a file containing directories whose files are to be sampled
# the sturcture is: directory - JPEGImages - xxx.jpg
# this script should be executed from a clean directory
list_of_dirs_file_name="list_of_dirs.txt"
declare -i sample_count=20

for fulldir in $(cat $list_of_dirs_file_name)
do
    echo $fulldir
    # strip last "/"
    # https://stackoverflow.com/questions/16623835/remove-a-fixed-prefix-suffix-from-a-string-in-bash
    export fulldir=${fulldir%"/"}
    export dir=`echo $fulldir | rev | cut -d '/' -f 1 | rev`
    echo $fulldir
    echo $dir
    if [ ! -d "$dir" ]; then
        mkdir $dir
    fi
    cd $dir
    export images=`ls $fulldir/JPEGImages > tmp.txt`
    # sample 50 files for each directory
    export simages=`cat tmp.txt | shuf -n $sample_count`
    echo $simages
    for simage in $simages
    do
        echo $fulldir/JPEGImages/$simage
        cp $fulldir/JPEGImages/$simage .
    done
    cd ..
done
