# linux-commands
Some useful linux commands


## find
### find specific type of files in all subdirectories and then delete
```find . -name "*.<file-type>" -type f -delete```

### find empty directory and then delete
```find . -type d -empty -delete```

### find directory but exclue "."(the current directory)
```find . -mindepth 1 -type d```

### find directory but exclue "." and force delete
```find . -mindepth 1 -type d -exec rm -r "{}" \;```

### find file with <word> in its name in the directory <directory>
```find <directory> -name <*word*>```

### find but exclue certain path
```find / -name <filename> -not -path "<the-path-to-be-excluded>"```


## grep
### search for a specific word from specific type of files in a directory
```grep '.*<word>.*' -rnw <directory>/*.<file-type>```

or

```grep -rnw <directory>/*.<file-type> -e '.*<word>.*'```

### search file, but just include some types of file
```grep <pattern> --include=\*.{type1, type2} -rnw <directory>```

### search file, but exclude some files
```grep <pattern> --exclude=<file-to-be-excluded> -rnw <directory>```

### find file in current directory and fetch the lowest level's directory name
```
grep <pattern> -rnw . | while IFS= read -r line ; do
>     echo "$line" | cut -d'/' -f2
> done
```
