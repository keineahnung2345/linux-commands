# linux-commands
Some useful linux commands

## check system information(either of one)
```sh
hostnamectl
uname -a
cat /etc/*-release
```

## check ubuntu system information
```sh
lsb_release -a
```
This can be installed by:
```sh
apt-get install -y lsb-release
```

## check cuda version
```sh
nvcc --version
```
or
```sh
nvcc -V
```

## check cudnn version
```sh
cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
```

## check if your machine is physical or virtual(either of one)
```sh
hostnamectl status
systemd-detect-virt
```

## check your cpu specification
```sh
lscpu
```

## check your gpu driver version
```sh
nvidia-smi
```

## check your gpu specification
```sh
nvidia-smi -q
```

## shutdown the machine
```sh
shutdown now
```

## reboot the machine
```sh
shutdown -r now
```

## backup your system
reference: https://help.ubuntu.com/community/BackupYourSystem/TAR
```sh
cd /
tar -cvpzf backup.tar.gz \
--exclude=/backup.tar.gz \
--exclude=/proc \
--exclude=/tmp \
--exclude=/mnt \
--exclude=/dev \
--exclude=/sys \
--exclude=/run \
--exclude=/media \
--exclude=/var/log \
--exclude=/var/cache/apt/archives \
--exclude=/usr/src/linux-headers* \
--exclude=/home/*/.gvfs \
--exclude=/home/*/.cache \
--exclude=/home/*/.local/share/Trash /
```
## check system log around the date \<yyyymmdd\>(It records the boot and shutdown histories)
```sh
cat /var/log/messages-<yyyymmdd> | less
```

## show all environment variables
```sh
printenv
```

## append current directory to the environment variable $PATH
```sh
export PATH=$PATH:`pwd`
```

## remove the environment variable <ENV_VAR_NAME>
```sh
unset <ENV_VAR_NAME>
```

## check port usage(either of one)
```sh
lsof -i -n -P
netstat -tulpn
```

## connect to remote host
```sh
ssh <username>@<ip-address>
```

## remove host name from known_hosts file(used when you have previously failed to login the host)
```sh
ssh-keygen -R <ip-address>
```

## check size of directories and files
### check total size of a directory, containing all its items
```sh
du -sh <dirname>
```

### check all files' size in current dir
```sh
du -h * | less
```

### check the size of items in \<dirname\> and sort them by their size in descending order
```sh
du -h --max-depth=1 <dirname> | sort -hr
```
or 
```sh
du -h -d 1 <dirname> | sort -hr
```

sort: -h for recognizing K,M,G, -r for descending order

## check file system information
```sh
df -h
```

## manage privilege of a file
### check the status of a file
```sh
stat <filename>
```

### show the privilege of a file
```sh
stat -c '%A' <filename>
```

### show the privilege, size and last modification time of a file
-l for long listing format, -a for showing hidden files, -h for showing size in human readable format
```sh
ls -lah <filename>
```

### ll, the short name for ls -l
```sh
ll <filename>
```

### change privilege of a file
```sh
chmod [u,o,g,a][+,-,=][r,w,x] <filename>
```

## manage processes
### monitor CPU, memory usage
```sh
top
```
or
```sh
ps aux
```

### check CPU, memory usage, sorted by CPU usage
```sh
ps --sort=-pcpu
```

### check how long a process has been running
```sh
ps -o etime= -p "<pid>"
```

### check the process name given a pid
```sh
ps -p <pid> -o comm=
```

### use pid(can be checked by top) to find out the location of the process
```sh
readlink -f /proc/<pid>/exe
```

### kill a process
```sh
kill -9 <pid>
```

## find
### find specific type of files in all subdirectories and then delete
```sh
find . -name "*.<file-type>" -type f -delete
```

### find empty directory and then delete
```sh
find . -type d -empty -delete
```

### find directory but exclue "."(the current directory)
```sh
find . -mindepth 1 -type d
```

### find directory but exclue "." and force delete
```sh
find . -mindepth 1 -type d -exec rm -r "{}" \;
```

### find file with \<word> in its name in the directory \<directory>
```sh
find <directory> -name "<*word*>"
```

### find file with \<word> in its name but exclude that with \<not-word>
```sh
find <directory> -name "<*word*>" -not -name "<*not-word*>"
```

### find but exclue certain path
```sh
find / -name "<filename>" -not -path "<the-path-to-be-excluded>"
```


## grep
### search for a specific word from specific type of files in a directory
```sh
grep '.*<word>.*' -rnw <directory>/*.<file-type>
```

or

```sh
grep -rnw <directory>/*.<file-type> -e '.*<word>.*'
```

### search file, but just include some types of file
```sh
grep <pattern> --include=\*.{type1, type2} -rnw <directory>
```

### search file, but exclude some files
```sh
grep <pattern> --exclude=<file-to-be-excluded> -rnw <directory>
```

### find file in current directory and fetch the lowest level's directory name
```sh
grep <pattern> -rnw . | while IFS= read -r line ; do
>     echo "$line" | cut -d'/' -f2
> done
```

### grep and show multiple surrounding lines
```sh
#show <b> lines before and <a> lines after the matched lines
<other-command> | grep <pattern> -B <b> -A <a> 
#show <c> lines before and after the matched lines
<other-command> | grep <pattern> -C <c> 
ex: docker run --help | grep runtime -C 5
```

## cut by space and get the last element
```sh
<other-command> | rev | cut -d' ' -f1 | rev
```

## download a file as </directory/file_name> from a url
```sh
wget -O </directory/file_name> <your-url>
```

## download a file to \<dirname\> from a url
```sh
wget -P <dirname> <your-url>
```

## iterate over the result of some command
```sh
<some-command> | (while read x; do <other-command-using-$x>; done)
ex: ls *.json | (while read x; do echo $x; done)
```

## let the command 'history' show the time when the commands are executed
```sh
export HISTTIMEFORMAT='%F %T '
history
```

## output non-ascii characters in shell
```sh
# method 1:
echo -en "$(<some-command-printing-non-ascii-characters>)"
# method 2:
apt-get install uni2ascii
<some-command-printing-non-ascii-characters> | ascii2uni -a U -q
```

## write or append the output to a file
```sh
<some-command> > <filename> #overwrite the file
<some-command> >> <filename> #append to the file
```

## redirect the error message of a command to a file
```sh
<some-command> > <filename.txt> 2>&1
```

## monitor GPU usage
```sh
watch -n0 nvidia-smi
```
