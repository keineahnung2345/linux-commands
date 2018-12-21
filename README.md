# linux-commands
Some useful linux commands

## check manual of a command
```sh
man <other-command>
```

## find out where \<other-command> exists
```sh
which <other-command>
```

or

```sh
whereis <other-command> #used to locate binary, souce for a command
```

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

## check CentOS/RHEL OS update level
one of them:
```bash
cat /etc/redhat-release
cat /etc/centos-release
cat /etc/system-release
cat /etc/os-release
rpm -qf /etc/redhat-release
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
hostnamectl status (for CentOS7)
systemd-detect-virt
facter | grep virtual (suitable for CentOS6)
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

## check current date and time
```sh
date
```

## check system log around the date \<yyyymmdd\>(It records the boot and shutdown histories)
```sh
cat /var/log/messages-<yyyymmdd> | less
```

## make the output of a command be a command and then execute it
```sh
eval $(<command-whose-output-is-the-commands-you-want-to-execute>)
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

## get ipaddress from ifconfig
```sh
ifconfig | grep -A 1 '<network-card-name>' | tail -1 | tr -s ' ' | cut -d' ' -f 3 | cut -d':' -f 2
```
\<network-card-name> could be enp1s0f1, eno1 or eth0 depending on your machine.

## check port usage(either of one)
```sh
lsof -i -n -P
netstat -tulpn #--tcp|-t, --udp|-u, -l, --listening
#-p, --program: Show the PID and name of the program to which each socket belongs.
#-n, --numeric: Show numerical addresses instead of trying to determine symbolic host, port or user names.
```

## check the process using the port \<port-number>
```sh
sudo lsof -i:<port-number>
```

## connect to remote host
```sh
ssh <username>@<ip-address>
```

## remove host name from known_hosts file(used when you have previously failed to login the host)
```sh
ssh-keygen -R <ip-address>
```

## copy multiple directories from remote host to current directory
```sh
scp <username>@<ip-address>:/some/remote/directory/\{a,b,c\} ./
```

## install a package
```sh
apt-get install -y <package-name>
```

## uninstall a package
```sh
apt-get purge -y <package-name>
```

## list installed packages by apt
```bash
apt list --installed
```

## list all version of a package(centos)
```sh
yum list --showduplicates <package-name>
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

## create a directory \<dir-name>(it will create any missing intermediate pathname components)
it will do nothing if \<dir-name> already exists, so we can always use this command without checking if a directory already exists!
```sh
mkdir -p <dir-name>
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

### open all privilege of \<dirname> and all its contents
```sh
chmod -R 777 <dirname>
```

### change the owner and group of \<dirname> to username and username
```sh
chown -R username:username <dirname>
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

### find directory(not need to be empty) and then delete
```sh
find . -name "<directory-name>" -type d -exec rm -rv {} \;
```
or
```sh
find . -name "<directory-name>" -type d -exec rm -rv {} +
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

### find: case-insensitive match
```sh
find / -iname "<filename>"
```

### find: suppress ```No such file or directory``` error
```sh
find / -name "<filename>" 2>/dev/null
```

### find a file and only return its parent directory
```sh
find / -name "<filename>" | xargs -I{} dirname {}
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

## create a .bak file for \<filename>
```sh
cp <filename>{,.bak}
```

## find and replace string in a \<filename>
```sh
sed -i '' 's/<regular expression>/<replacement>/g' <filename>
```

## delete the \<N>-th line from outside the file
```sh
sed '<N> d' <filename>
```

## translate or delete characters - squeeze multiple \<char> into one
```sh
tr -s '<char>'
```

## cut by \<delimiter> and get the specific \<fields>
```sh
cut -d '<delimiter>' -f <fields>
```
\<fileds> could be 1 or "1,2,3".

## cut by space and get the last element
```sh
<other-command> | rev | cut -d' ' -f1 | rev
```

## reverse the output of \<other-command>
```sh
<other-command> | tac
```

## download a file as </directory/file_name> from a url
Method 1: wget
```sh
wget -O </directory/file_name> <your-url>
```

Method 2: curl
```sh
curl -o </directory/file_name> <your-url>
```

## download a file to \<dirname\> from a url
```sh
wget -P <dirname> <your-url>
```

## download a file only when the file does not exist
```sh
wget -nc <your-url>
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

## count number of lines of other command's output
```sh
<some-command> | wc -l
```

## zip \<foldername> to \<foldername>.zip
```sh
zip -r <foldername>.zip <foldername>
```

## unzip a file to a desinated directory
```sh
unzip <xxx.zip> -d </target/directory/to/unzip>
```

## extract .gz file
```sh
gunzip <xxx.gz>
```
or
```sh
gzip -d <xxx.gz>
```

## show difference between two files
```sh
diff <file1> <file2>
```

## show difference between two directories
```sh
diff -r -q <dir1> <dir2>
```

## monitor GPU usage
```sh
watch -n0 nvidia-smi
```

## list the last \<num_lines> lines in \<filename.txt>
```sh
tail -n <num_lines> <filename.txt>
```

## Display the output of \<other-command> in pages and scroll to bottom automatically
+G performs the action of scrolling to bottom automatically
```sh
<other-command> | less +G
```

## run your command in background, write its output to a text file, and watch that text file simultaneously
```sh
nohup <some-command> &><filename.txt> &
tail -f <filename.txt>
```

## create a symbolic link(soft link) of \<target> named \<linkname>
```bash
ln -s <target> <linkname>
```
Difference of hard and soft link can be found in: [Linux ln command](https://www.computerhope.com/unix/uln.htm).


## remove a symbolic link
Reference to: [How to Remove a Symbolic Link (Symlink)](http://osxdaily.com/2016/05/25/how-delete-symbolic-link-symlink/)
```bash
unlink <linkname>
```

or

```bash
rm -rf <linkname>
```

## mount a \<dir1> to \<dir2>
```bash
mkdir <dir2>
mount --bind <dir1> <dir2>
```
--bind makes it possible to remount part of the file hierarchy somewhere else, and it solves the error: 

> mount:  <dir1> is not a block devicere

## unmount \<dir2>
```bash
umount <dir2>
```

## get the full path of a symbolic link's target
```bash
readlink -e <linkname>
```
readlink -f returns something even for non-existing \<linkname>

readlink -e will return null for non-existing \<linkname>
