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
