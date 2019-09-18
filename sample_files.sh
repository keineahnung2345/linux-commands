#!/bin/bash
#this script sample 100 .jpg, .xml files from JPEGImages and Annotations separately(VOC directory structure)

ls JPEGImages > fnames.txt
if [ -d sample ]; then
    rm -r sample
fi
mkdir sample
sed -i 's/.jpg//g' fnames.txt
shuf -n 100 fnames.txt -o fnames.txt
for fname in $(cat fnames.txt)
do
    cp -r $(find . -name "*$fname*" -not -path "./sample*") sample
done
rm fnames.txt
tar -czf sample.tar.gz sample
