#!/bin/bash
# stratified sampling
# this script should be run under the directory containing VOCdevkit
# VOCdevkit structure: VOCdevkit -> VOC*(VOC2019) -> Annotations/JPEGImages
# class_names_file: one class name per line, class names will be found in xml files. Also we will create folders under $dstdir named after the class names
# dstdir: the save directory
# sample_count: sample how many images per class
class_names_file="class_names.txt"
dstdir="sample"
declare -i sample_count=5

if [ -d "$dstdir" ]; then
    rm -r $dstdir
fi
mkdir $dstdir

for classname in $(cat $class_names_file); do
    echo $classname
    mkdir $dstdir"/"$classname
    declare -i count=0
    for xmlfname in $(grep $classname -rlw VOCdevkit/VOC*/Annotations | head -$sample_count); do
        imgfname=$xmlfname
        imgfname=${imgfname//Annotations/JPEGImages}
        imgfname=${imgfname//xml/jpg}
        echo $imgfname
        labelfname=$xmlfname
        labelfname=${labelfname//Annotations/labels}
        labelfname=${labelfname//xml/txt}
        cp $imgfname $dstdir"/"$classname
        cp $xmlfname $dstdir"/"$classname
        cp $labelfname $dstdir"/"$classname
        count=`expr ${count} + 1`
        if [ "$count" -gt $sample_count ]; then
            break
        fi
    done
done
