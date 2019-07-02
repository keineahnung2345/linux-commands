# linux-commands
Some useful linux commands

## switch to root environment(Ubuntu)
[Why does su fail with “authentication error”? [duplicate]](https://askubuntu.com/questions/446570/why-does-su-fail-with-authentication-error)

[What are the differences between “su”, “sudo -s”, “sudo -i”, “sudo su”?](https://askubuntu.com/questions/70534/what-are-the-differences-between-su-sudo-s-sudo-i-sudo-su)
```sh
sudo -s # ~/.bashrc is respected
sudo -i # ~/.bashrc is ignored
```

## restart bash
[Restart bash from terminal without restarting the terminal application (mac)?](https://unix.stackexchange.com/questions/217905/restart-bash-from-terminal-without-restarting-the-terminal-application-mac)
```sh
exec bash
```

## list all commands recognized by linux shell
```sh
compgen -c 
```

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

## check ubuntu system information(version)
```sh
lsb_release -a
```
This can be installed by:
```sh
apt-get install -y lsb-release
```

## check ubuntu architecture
```sh
dpkg --print-architecture
# amd64
```

## check CentOS/RHEL OS update level(version)
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

When `nvcc` cannot be found:

```sh
cat /usr/local/cuda/version.txt
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

## export an environment variable
```sh
export <env_var>="<value>"
```
Note that there should not be any spaces before or after '=', or it throws `bad variable name` or ```bash: export: `=': not a valid identifier```.

## concat string to an environment variable
```sh
echo $<env_var>"str_to_concat"
```

## append current directory to the environment variable $PATH
```sh
export PATH=$PATH:`pwd`
```
To make it work forever, add this line into the bottom of `~/.bashrc` and then `source ~/.bashrc`.

## remove the environment variable <ENV_VAR_NAME>
```sh
unset <ENV_VAR_NAME>
```

## get host name
```sh
hostname
```

## get ipaddress
```sh
ifconfig | grep -A 1 '<network-interface-name>' | tail -1 | tr -s ' ' | cut -d' ' -f 3 | cut -d':' -f 2
```
\<network-card-name> could be enp1s0f1, eno1 or eth0 depending on your machine.

```sh
ip route get 1 | awk '{print $NF;exit}'
```

or 

```sh
hostname -i
```

or 

```sh
hostname -I | cut -d' ' -f1
```

## restart a specific network interface
using ifdown:
```sh
ifdown <network-interface-name> && ifup <network-interface-name>
```
using ifconfig (cannot reconnect for me):
```sh
ifconfig <network-interface-name> down && ifconfig <network-interface-name> up
```

## check port usage(either of one)
```sh
lsof -i -n -P
netstat -tulpn #--tcp|-t, --udp|-u, -l, --listening
#-p, --program: Show the PID and name of the program to which each socket belongs.
#-n, --numeric: Show numerical addresses instead of trying to determine symbolic host, port or user names.
```

## check the process using the port \<port-number>
```sh
lsof -i:<port-number>
```

```sh
lsof -n -i4TCP:<port-number>
```

## connect to remote host
```sh
ssh <username>@<ip-address>
```

## send command to remote host and get result locally
```sh
ssh -t username@host '<your-command>'
```

## remove host name from known_hosts file(used when you have previously failed to login the host)
```sh
ssh-keygen -R <ip-address>
```

## copy multiple directories from remote host to current directory
```sh
scp <username>@<ip-address>:/some/remote/directory/\{a,b,c\} ./
```

## scp and rename the file
```sh
scp <username>@<ip-address>:/some/remote/directory/<original-name>.zip <new-name>.zip 
```

## show package description
```sh
apt-cache search <package-name>
```

## show package version details
```sh
apt-cache show <package-name>
```

## apt-get update
```sh
apt-get update
```

[Issue with fetching http://deb.debian.org/debian/dists/jessie-updates/InRelease with docker](https://superuser.com/questions/1423486/issue-with-fetching-http-deb-debian-org-debian-dists-jessie-updates-inrelease)

In Dockerfile, when using docker `monsantoco/min-jessie:latest`, if met with :
```
W: Failed to fetch http://http.debian.net/debian/dists/jessie-updates/InRelease  Unable to find expected entry 'main/binary-amd64/Packages' in Release file (Wrong sources.list entry or malformed file)

E: Some index files failed to download. They have been ignored, or old ones used instead.
```

This can be solved by adding: 
```
printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
```
in front of `apt-get update`.

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

## search packages(centos)
```sh
yum search <xxx>
```
ex: yum search java | grep 'java-1.8.0-openjdk-'

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

## check file structure
```sh
tree
```

or

```
tree </path/to/directory>
```

## check file system information
```sh
df -h
```

## find out the device where a directory is on
```sh
df <dirname>
```

## use du with find
```sh
find <dirname> -name <filename> -print0 | du --files0-from=- -hc
```
This will show all matching files with its size in human-readable format.

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
Sample output:
```
  File: 'faster-rcnn.pytorch/'
  Size: 4096      	Blocks: 8          IO Block: 4096   directory
Device: 802h/2050d	Inode: 120856675   Links: 10
Access: (0755/drwxr-xr-x)  Uid: ( 1001/   user1)   Gid: (    0/    root)
Access: 2019-06-27 16:50:29.845551752 +0800
Modify: 2019-06-27 16:51:01.705798284 +0800
Change: 2019-06-27 16:51:01.705798284 +0800
 Birth: -
```

### show the privilege of a file
[How to find owner and group of a directory?](https://askubuntu.com/questions/175054/how-to-find-owner-and-group-of-a-directory)
```sh
stat -c '%A' <filename>
```
Sample output:
```
drwxr-xr-x
```

### show the user and group of a file
```sh
stat -c "%U %G" <filename>
```
Sample output:
```
user1 root
```

### show the privilege, size and last modification time of a file
-l for long listing format, -a for showing hidden files, -h for showing size in human readable format
```sh
ls -lah <filename>
```
Sample output:
```
total 212K
drwxr-xr-x 10 user1 root  4.0K Jun 27 16:51 .
drwxr-xr-x  9 user1 user1 4.0K Jun 27 16:40 ..
drwxr-xr-x  2 user1 root  4.0K Jun 26 10:37 cfgs
-rwxr-xr-x  1 user1 user1 1.1K Jun 26 11:11 class_names.pkl
```
The 3rd and 4th columns are the user and group of files respectly.

### show modification time of files in current directory
-l for long listing format, -d for only showing directories' names rather than their contents
```sh
ls -ld *
```

### ll, the short name for ls -l
```sh
ll <filename>
```

### ls, show one item in separate line
```sh
ls -1 <dirname>
```

## ls, recursively
```sh
ls -R <dirname>
```

### change privilege of a file
```sh
chmod [u,o,g,a][+,-,=][r,w,x] <filename>
```

### open all privilege of \<dirname> and all its contents
```sh
chmod -R 777 <dirname>
```

### change the owner and group of \<dirname> and its children to username and groupname
```sh
chown -R username:groupname <dirname/*>
```
Only change owner:
```sh
chown -R username <dirname/*>
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
to show full command in `ps aux`:
[Viewing full output of PS command](https://stackoverflow.com/questions/2159860/viewing-full-output-of-ps-command)
```sh
ps aux | less -+S
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
### find file and show their size
```sh
find . -name "<filename>" -type f | xargs du -sh
```

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

### find in current directory, not recursive
```sh
find . -maxdepth 1 -name "<*word*>"
```

### find directory with name length greater than \<length> and delete
```sh
find . -maxdepth 1 -print| awk -F/ ' length($NF)> <length> ' | xargs rm -rf
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

### find executable file
```sh
find / -executable -type f
```
A directory is executable if one can cd into it. 
So one might only want to find executable "file".

### find files by their modification time
[Find files based on modified date(specifying the exact hour) [duplicate]](https://unix.stackexchange.com/questions/185897/find-files-based-on-modified-datespecifying-the-exact-hour)
```sh
find . -newermt "<year1>-<month1>-<day1> 00:00:00" ! -newermt "<year2>-<month2>-<day2> 00:00:00"
```

## print the content of a file
### show line number
```sh
cat -n <filename>
```

## use cat to write file
```sh
cat > <filename> << EOF
<line1>
<line2>
<line3>
EOF
```

## use echo to write file
```sh
echo "<text>" > <filename>
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

### escape dot in grep
[Using grep to search for a string that has a dot in it](https://stackoverflow.com/questions/10346816/using-grep-to-search-for-a-string-that-has-a-dot-in-it)
```sh
grep '<xxx\.xxx>' -rnw <directory>
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

### grep a word within files with specific file extension
```sh
grep -rnw --include=\*.<file-extension> ".*<word>.*"
```
ex: grep -rnw --include=\*.sh ".*SPARK.*" .

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

## use curl to test REST API
[使用curl指令測試REST服務](http://blog.kent-chiu.com/2013/08/14/testing-rest-with-curl-command.html)
```sh
curl -X POST "<ip-address>:<port>/<subpage>" -d "<param1>=<value1>"
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
method 1:
```sh
echo -en "$(<some-command-printing-non-ascii-characters>)"
```

method 2:

[How to convert \uXXXX unicode to UTF-8 using console tools in *nix](https://stackoverflow.com/questions/8795702/how-to-convert-uxxxx-unicode-to-utf-8-using-console-tools-in-nix)

```sh
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

## compress to a tar.gz file
```sh
tar -czvf <xxx.tar.gz> <xxx>
```

## show progress bar while compressing to a tar.gz file
[Is there a way to see any tar progress per file?](https://superuser.com/questions/168749/is-there-a-way-to-see-any-tar-progress-per-file)
```sh
tar cf - <xxx> -P | pv -s $(du -sb <xxx> | awk '{print $1}') | gzip > <xxx>.tar.gz
```

## show progress bar while unzip a tar.gz file
```sh
pv <xxx.tar.gz> | tar xzf - -C </target/directory/to/unzip>
```

## extract .tar.gz file
```sh
tar -xzvf <xxx.tar.gz>
```

## extract .tar.gz file to a directory
```sh
tar -xzf <xxx.tar.gz> -C <xxx>
```

## extract .gz file
```sh
gunzip <xxx.gz>
```
or
```sh
gzip -d <xxx.gz>
```

## extract .7z file
```sh
7za -y x <xxx.7z>
```

## show difference between two files
```sh
diff <file1> <file2>
```

## show difference between two directories
```sh
diff -r -q <dir1> <dir2>
```

## show difference between two directories, exclude some files
```sh
diff -x "<pattern>" -r -q <dir1> <dir2>
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
nohup <some-command>  </dev/null &><filename.txt> &
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

## check the contents of jar file
```bash
jar tf <xxx.jar>
```

or

```bash
jar tvf <xxx.jar>
```

## check the contents of a zip file
```bash
less <xxx.zip>
```

## perform set operation on \<file1> and \<file2>
find difference of \<file1> and \<file2>
```
comm -23 <(sort <file1>) <(sort <file2>)
```
More details: [Linux comm command brief tutorial](http://www.unixcl.com/2009/08/linux-comm-command-brief-tutorial.html)

[bash, Linux: Set difference between two text files](https://stackoverflow.com/questions/2509533/bash-linux-set-difference-between-two-text-files)

## ab: test the capability of serving of a website

```bash
ab -n <total-requests-count> -c <concurrent-requests-count> <url>
```

send \<total-requests-count> requests to \<url> in which <concurrent-requests-count> of them are concurrent.

## to exit X server

```bash
sudo service lightdm stop
```

## copy : Argument list too long
[Argument list too long when copying files](https://askubuntu.com/questions/217764/argument-list-too-long-when-copying-files)

```bash
for i in *.jpg; do cp "$i" /target/directory; done
```

## ls:  Argument list too long
[What is the fastest way in terminal to get a count of files when there is so many of them? [duplicate]](https://askubuntu.com/questions/1084737/what-is-the-fastest-way-in-terminal-to-get-a-count-of-files-when-there-is-so-man)

Use the following to replace `ls /dir/name/*.jpg | wc -l`
```bash
ls -l /dir/name | fgrep .jpg | wc -l
```
