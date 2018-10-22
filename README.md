# linux-commands
Some useful linux commands

## check system information(either of one)
```
hostnamectl
uname -a
cat /etc/*-release
lsb_release -a (only for ubuntu)
```

## check if your machine is physical or virtual(either of one)
```
hostnamectl status
systemd-detect-virt
```

## check your cpu specification
```
lscpu
```

## shutdown the machine
```
shutdown now
```

## reboot the machine
```
shutdown -r now
```

## check system log around the date \<yyyymmdd\>(It records the boot and shutdown histories)
```
cat /var/log/messages-<yyyymmdd> | less
```

## show all environment variables
```
printenv
```

## append current directory to the environment variable $PATH
```
export PATH=$PATH:`pwd`
```

## remove the environment variable <ENV_VAR_NAME>
```
unset <ENV_VAR_NAME>
```

## check port usage(either of one)
```
lsof -i -n -P
netstat -tulpn
```

## check size of directories and files
### check total size of a directory, containing all its items
```
du -sh <dirname>
```

### check all files' size in current dir
```
du -h * | less
```

### check the size of items in \<dirname\> and sort them by their size in descending order
```
du -h --max-depth=1 <dirname> | sort -hr
```
or 
```
du -h -d 1 <dirname> | sort -hr
```

sort: -h for recognizing K,M,G, -r for descending order

## check file system information
```
df -h
```

## manage privilege of a file
### check the status of a file
```
stat <filename>
```

### show the privilege of a file
```
stat -c '%A' <filename>
```

### show the privilege, size and last modification time of a file
```
ls -lah <filename>
```

### change privilege of a file
```
chmod [u,o,g,a][+,-,=][r,w,x] <filename>
```

## manage processes
### monitor CPU, memory usage
```
top
```
or
```
ps aux
```

### check CPU, memory usage, sorted by CPU usage
```
ps --sort=-pcpu
```

### check how long a process has been running
```
ps -o etime= -p "<pid>"
```

### check the process name given a pid
```
ps -p <pid> -o comm=
```

### use pid(can be checked by top) to find out the location of the process
```
readlink -f /proc/<pid>/exe
```

### kill a process
```
kill -9 <pid>
```

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

### grep and show multiple surrounding lines
```
#show <b> lines before and <a> lines after the matched lines
<other-command> | grep <pattern> -B <b> -A <a> 
#show <c> lines before and after the matched lines
<other-command> | grep <pattern> -C <c> 
ex: docker run --help | grep runtime -C 5
```

## cut by space and get the last element
```
<other-command> | rev | cut -d' ' -f1 | rev
```

## download a file as </directory/file_name> from a url
```
wget -O </directory/file_name> <your-url>
```

## download a file to \<dirname\> from a url
```
wget -P <dirname> <your-url>
```

## iterate over the result of some command
```
<some-command> | (while read x; do <other-command-using-$x>; done)
ex: ls *.json | (while read x; do echo $x; done)
```

## let the command 'history' show the time when the commands are executed
```
export HISTTIMEFORMAT='%F %T '
history
```

## output non-ascii characters in shell
```
# method 1:
echo -en "$(<some-command-printing-non-ascii-characters>)"
# method 2:
apt-get install uni2ascii
<some-command-printing-non-ascii-characters> | ascii2uni -a U -q
```

## write or append the output to a file
```
<some-command> > <filename> #overwrite the file
<some-command> >> <filename> #append to the file
```

## monitor GPU usage
watch -n0 nvidia-smi
