for i in $(cat xxx.txt); do
    # $i is the filename without extension
    cp /src/dir/$i.<filetype> /dst/dir
done
