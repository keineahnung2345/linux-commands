#!/bin/sh
# train.txt contains full path of images
# class_names.txt contains one class name per line
# this script count bbox from train.txt's images' corresponding label files and combine with class_names.txt to create class_names_with_count.txt

cp train.txt train_label.txt
# replace JPEGImages->labels, jpg->txt in train.txt
sed -i 's/JPEGImages/labels/g' train_label.txt
sed -i 's/jpg/txt/g' train_label.txt
# "*.txt" is the content of relaced train.txt
cat train_label.txt | xargs -i awk -F" " '{print $1}' {} | sort -V | uniq -c > bbox_count.txt
awk -F" " '{print $1}' bbox_count.txt > only_count.txt
paste class_names.txt only_count.txt | expand -t $(( $(wc -L < class_names.txt) + 2 )) > class_names_with_count.txt
rm -r only_count.txt bbox_count.txt train_label.txt
