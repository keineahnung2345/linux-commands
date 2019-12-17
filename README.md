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

## list all users
[How to List Users in Linux](https://linuxize.com/post/how-to-list-users-in-linux/)
```sh
less /etc/passwd
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

## check cpu specification
```sh
lscpu
```
or:
```sh
cat /proc/cpuinfo
```

## check cpu microarchitecture
[how to find out intel architecture family from command line](https://unix.stackexchange.com/questions/230634/how-to-find-out-intel-architecture-family-from-command-line)
```sh
gcc -march=native -Q --help=target|grep march
```
Sample output:
```
  -march=                     		broadwell
```

## check external devices' information
```sh
lsusb
```

## check your gpu driver version
```sh
nvidia-smi
```

## monitor GPU usage
### nvidia-smi
```sh
nvidia-smi --loop=1
nvidia-smi -l=1
```
or
```
nvidia-smi --loop-ms=500
nvidia-smi -lms=500
```
or
```sh
watch -n0 nvidia-smi
```

### gpustat
[How to measure GPU usage?](https://askubuntu.com/questions/387594/how-to-measure-gpu-usage)

[wookayin/gpustat](https://github.com/wookayin/gpustat)
```sh
gpustat -cp
```
Note: -c for show command, -p for show pid

Install it by `pip`.

## check your gpu specification
```sh
nvidia-smi -q
```

## a enhanced nvidia-smi, showing processes's info
First install [peci1/nvidia-htop](https://github.com/peci1/nvidia-htop), and then:
```sh
nvidia-htop.py -c -l 50
```
This will show the processes' `PID`, `USER`, `GPU`, `MEM`, `%CPU`, `%MEM`, `TIME`, `COMMAND`.

## check gpu memory size in detail
[How to find out shared memory and global memory size of GPU?](https://stackoverflow.com/questions/38041148/how-to-find-out-shared-memory-and-global-memory-size-of-gpu)
```sh
# cd <cuda_installatino_dir>/samples/1_Utilities/deviceQuery
cd /usr/local/cuda/samples/1_Utilities/deviceQuery
# compile the cpp file
make
# run deviceQuery
./deviceQuery
```

Result:

```
./deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "GeForce GTX 1080"
  CUDA Driver Version / Runtime Version          10.1 / 10.1
  CUDA Capability Major/Minor version number:    6.1
  Total amount of global memory:                 8116 MBytes (8510701568 bytes)
  (20) Multiprocessors, (128) CUDA Cores/MP:     2560 CUDA Cores
  GPU Max Clock rate:                            1835 MHz (1.84 GHz)
  Memory Clock rate:                             5005 Mhz
  Memory Bus Width:                              256-bit
  L2 Cache Size:                                 2097152 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
  Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 2 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            Yes
  Supports Cooperative Kernel Launch:            Yes
  Supports MultiDevice Co-op Kernel Launch:      Yes
  Device PCI Domain ID / Bus ID / location ID:   0 / 1 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.1, CUDA Runtime Version = 10.1, NumDevs = 1
Result = PASS
```

## solve `NVIDIA NVML Driver/library version mismatch`
[NVIDIA NVML Driver/library version mismatch](https://stackoverflow.com/questions/43022843/nvidia-nvml-driver-library-version-mismatch)
```sh
lsmod | grep nvidia
rmmod <mod-name1> #follow the order from the last command
rmmod <mod-name2>
# rmmod ...
nvidia-smi # should work now
```

## kill all processing using GPU
[How do I kill all the computer processes shown in nvidia-smi?](https://www.quora.com/How-do-I-kill-all-the-computer-processes-shown-in-nvidia-smi)
```sh
kill -9 $(nvidia-smi | sed -n 's/|\s*[0-9]*\s*\([0-9]*\)\s*.*/\1/p' | sort | uniq | sed '/^$/d')
```

## cuda executable profiling
```sh
nvprof ./<cuda_executable>
```

## check Intel GPU Info
```sh
glxinfo | grep -i device
```
Sample output:
```
    Device: Mesa DRI Intel(R) Iris Plus Graphics 650 (Kaby Lake GT3e)  (0x5927)
```
Note that it should be used on a computer with GUI, otherwise it gives the following error:
```
Error: unable to open display
```

## check Intel GPU usage
Ref: [Check your intel gpu usage via commandline](https://medium.com/@niklaszantner/check-your-intel-gpu-usage-via-commandline-11196a7ee827)
```sh
intel_gpu_top
```

## check OpenCL version
```sh
clinfo --version
```
Sample output:
```
clinfo version 2.1.16.01.12
```

## find process id and then kill it
```sh
kill -9 `pgrep <your_exec_file_name>`
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

## measure running time of a command
```sh
time <other-command>
```
Output:
```
real	1m4.743s
user	0m54.368s
sys	0m16.128s
```

## check current date and time
```sh
date
```

## get time in seconds since epoch
[Get current time in seconds since the Epoch on Linux, Bash](https://stackoverflow.com/questions/1092631/get-current-time-in-seconds-since-the-epoch-on-linux-bash)
```sh
date +%s
```

This is same as the following in Python:
```py
import time
time.time()
```

## change timezone
```sh
cd /usr/share/zoneinfo
tzselect # and then follow the instructions
```

To make this change pernament, add the following line in the last of `~/.profile`:
```
TZ='Asia/Taipei'; export TZ
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

## find an environment varialbe by name
```sh
env | grep -i "<env_var_name>"
```

## export an environment variable
```sh
export <env_var>="<value>"
```
Note that there should not be any spaces before or after '=', or it throws `bad variable name` or ```bash: export: `=': not a valid identifier```.

Ref: [How do I add environment variables?](https://askubuntu.com/questions/58814/how-do-i-add-environment-variables)

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
[How to Restart Network Interface in Linux](https://www.cyberciti.biz/faq/linux-restart-network-interface/)

using ifdown:
```sh
ifdown <network-interface-name> && ifup <network-interface-name>
```
using ifconfig (cannot reconnect for me):
```sh
ifconfig <network-interface-name> down && ifconfig <network-interface-name> up
```

For Ubuntu, also:
```sh
sudo /etc/init.d/networking restart
```
or 
```sh
sudo systemctl restart networking
```

## configure static(fixed) ip address
Ref to [Configure static IP address on Ubuntu 16.04 LTS Server](https://michael.mckinnon.id.au/2016/05/05/configuring-ubuntu-16-04-static-ip-address/):

Edit the file `/etc/network/interfaces`:
```sh
auto lo
iface lo inet loopback

auto <interface_name>
iface <interface_name> inet static
address <the_static_ip_address_to_be_set>
netmask 255.255.255.0
gateway <gateway>
dns-nameservers <gateway> 8.8.8.8 8.8.4.4
```

`<interface_name>` can be found by `ifconfig`, and `<gateway>` can be found by `route`.

Example:
```sh
auto lo
iface lo inet loopback

auto enp0s31f6
iface enp0s31f6 inet static
address 10.56.6.90
netmask 255.255.255.0
gateway 10.56.6.254
dns-nameservers 10.56.6.254 8.8.8.8 8.8.4.4
```

And then reboot.

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

## connect to remote host's \<port-number>
```sh
ssh <username>@<ip-address> -p<port-number>
```

## send command to remote host and get result locally
```sh
ssh -t username@host '<your-command>'
```

## keep ssh connection alive
[Keep SSH session alive [closed]](https://stackoverflow.com/questions/25084288/keep-ssh-session-alive)

Possible solution to `packet_write_wait: Connection to xx.xx.xx.xx port 22: Broken pipe`.

Create `~/.ssh/config`, fill it with:
```
Host *
    ServerAliveInterval 240
```
And then:
```sh
chmod 600 ~/.ssh/config
```

## remove host name from known_hosts file(used when you have previously failed to login the host)
```sh
ssh-keygen -R <ip-address>
```

## ssh with password
[How to pass password to scp?](https://stackoverflow.com/questions/50096/how-to-pass-password-to-scp)
```sh
sshpass -p <password> scp -r user@example.com:/some/remote/path /some/local/path
```

## copy multiple directories from remote host to current directory
```sh
scp <username>@<ip-address>:/some/remote/directory/\{a,b,c\} ./
```

## scp and rename the file
```sh
scp <username>@<ip-address>:/some/remote/directory/<original-name>.zip <new-name>.zip 
```

## rsync: transfer file between local and remote
```sh
rsync -P /local/file <username>@<ip-address>:/some/remote/directory
```
The `-P` option shows the progress.

## show package description
```sh
apt-cache search <package-name>
```

## show package version details
```sh
apt-cache show <package-name>
```

## set(or unset) apt proxy
[Configure proxy for APT?](https://askubuntu.com/questions/257290/configure-proxy-for-apt)

In `/etc/apt/apt.conf`, add something like:
```
Acquire::http::proxy "http://child-prc/intel.com:913/";
Acquire::https::proxy "https://child-prc/intel.com:913/";
```

To unset, just clear `/etc/apt/apt.conf`.

After changing the file, it will take effect immediately.

## set(or unset) system proxy
Set system proxy:
```sh
export http_proxy=http://child-prc.intel.com:913/
export https_proxy=https://child-prc.intel.com:913/
```

Unset system proxy:
```sh
unset http_proxy
unset https_proxy
```

In `/etc/environment`, comment the following lines:
```
http_proxy="http://child-prc.intel.com:913/"
https_proxy="https://child-prc.intel.com:913/"
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
[What is the correct way to completely remove an application?](https://askubuntu.com/questions/187888/what-is-the-correct-way-to-completely-remove-an-application)
```sh
apt-get purge -y <package-name>
```
or
```
apt-get --purge autoremove <package-name>
```

## download .deb and not install
```sh
apt-get install --download-only <package-name>
```

The `.deb` file will be put in `/var/cache/apt/archives`.

## list packages installed
```bash
ldconfig -p | grep <package-name>
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
### check total size of a directory, containing all its items(the unit is KB, MB or GB depending on its size)
```sh
du -sh <dirname>
```

### check total size of a directory in bytes
[How can I see a folder's exact size in bytes?](https://askubuntu.com/questions/104848/how-can-i-see-a-folders-exact-size-in-bytes/104850)
```sh
du -s -B1 <dirname>
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

## check memory size
```sh
free    # in KB
free -m # in MB
free -g # in GB
```
or
```sh
cat /proc/meminfo
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

### show the size of a file
```sh
stat -c "%s %n" <filename>
```
Sample output:
```
1091 README.md
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

### ls, sorted by modification time
[How can I sort the output of 'ls' by last modified date?](https://superuser.com/questions/147027/how-can-i-sort-the-output-of-ls-by-last-modified-date)

sorted by modification time, descending
```sh
ls -lt
```

sorted by modification time, ascending:
```sh
ls -ltr
```

### ll, the short name for ls -l
```sh
ll <filename>
```

### ls, show one item in separate line
```sh
ls -1 <dirname>
```

### ls, show directories starting with \<S>(only print their names and don't show their children)
```sh
ls -d <S>*/
```
or
```sh
echo <S>*/
```

### ls, recursively
```sh
ls -R <dirname>
```

### ls, list absolute path(full path)
[How can I generate a list of files with their absolute path in Linux?](https://stackoverflow.com/questions/246215/how-can-i-generate-a-list-of-files-with-their-absolute-path-in-linux)

For directories (the / after ** is needed in bash to limit it to directories):
```sh
ls -d -1 "$PWD/"**/
```

For files and directories directly under the current directory, whose names contain a .:
```sh
ls -d -1 "$PWD/"*.*
```

For everything:
```sh
ls -d -1 "$PWD/"**/*
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
This solves the error of `scp: /dirname/filename: Permission denied`, `chmod` may also help.

## manage processes
### monitor CPU, memory usage
```sh
top
# specify number of iterations as 1
top -n1
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
### find, return full directory
[How can I generate a list of files with their absolute path in Linux?](https://stackoverflow.com/questions/246215/how-can-i-generate-a-list-of-files-with-their-absolute-path-in-linux)
```sh
find "$PWD" -name "<filename>"
find "$(pwd)" -name "<filename>"
```

### find file and show their size
```sh
find . -name "<filename>" -type f | xargs du -sh
```
Note that the double quotes around <filename> are important!

### find directory and don't show their children
[How to find only directories without subdirectories? [duplicate]](https://unix.stackexchange.com/questions/497185/how-to-find-only-directories-without-subdirectories)
```sh
find . -type d -links 2 ! -empty
```

### find file and only print their filenames(not including their directory path)
```sh
find . -type f -printf "%f\n"
```

### find files without an extension
```sh
find . -type f ! -name "*.*"
```

### find specific type of files in all subdirectories and then delete
```sh
find . -name "*.<file-type>" -type f -delete
```
or
```sh
find . -name "*.<file-type>" | xargs -i rm {}
```
or
```sh
find . -name "*.<file-type>" -exec rm {} \;
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

### find and move
[How to integrate mv command after find command?](https://unix.stackexchange.com/questions/154818/how-to-integrate-mv-command-after-find-command)

```sh
find . -name "<filename>" -exec mv -t "<dst_path>" {} +
```

In Mac, where `-t` is an illegal option to `mv`:

```sh
find . -name "<filename>" -exec mv {} "<dst_path>" \;
```

### find and copy
[Find and copy files](https://stackoverflow.com/questions/5241625/find-and-copy-files)

```sh
find . -name "<filename>" -exec cp {} "<dst_path>"  \;
```

### find in current directory, not recursive, max depth = 1
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

### find but exclude certain path
[How to exclude a directory in find . command](https://stackoverflow.com/questions/4210042/how-to-exclude-a-directory-in-find-command)
```sh
find / -name "<filename>" -not -path "./<the-path-to-be-excluded>*"
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

### find last modified file recursively
[How to recursively find the latest modified file in a directory?](https://stackoverflow.com/questions/4561895/how-to-recursively-find-the-latest-modified-file-in-a-directory)
```sh
find . -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" "
```

### find, using regular expression
To find files like 1567481018771_res.jpg or 1567481433382_res.jpg.
```sh
find . -regex "./[0-9]+_res\.jpg"
```

To find files like 1567481019363.jpg and 1567481189545.jpg.
```sh
find . -regex "./[0-9]+\.jpg"
```

### find in multiple directories with same prefix
```sh
find <prefix>* -name "*.jpg"
```

### list all subdirectories' file count
[How to report number of files in all subdirectories?](https://unix.stackexchange.com/questions/23130/how-to-report-number-of-files-in-all-subdirectories)

This will show full subdirectory name:
```sh
for f in *; do [ -d ./"$f" ] && find ./"$f" -maxdepth 1 -exec echo \; | wc -l && echo $f; done
```
Sample output:
```
      72
$RECYCLE.BIN
      17
8.9
       3
System Volume Information
```

or 

This won't show full subdirectory name, but now subdirectory name and its file count are in the same line:
```sh
for f in *; do [ -d ./"$f" ] && find ./"$f" -maxdepth 1 -exec echo \;|wc -l|tr '\n' ' ' && echo $f; done|awk '{print $2"\t"$1}'
```
Sample output:
```
$RECYCLE.BIN	72
8.9	17
System	3
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

## concat files and generate a new one
```sh
cat a.txt b.txt > new.txt
```

## use echo to write file
```sh
echo "<text>" > <filename>
```

## use printf to write multiple lines to a file
```sh
printf '<line1>\n<line2>' > <filename>
```
If using `echo`, `\n` itself rather than a newline will be written to the file.

## grep
### search for a word, show line number
```sh
grep -n ".*<word>.*" <filename>
```

### search for a specific word from specific type of files in a directory
```sh
grep '.*<word>.*' -rnw <directory>/*.<file-type>
```

or

```sh
grep -rnw <directory>/*.<file-type> -e '.*<word>.*'
```

### search for a word, but exclude another
[Grep regex NOT containing string](https://stackoverflow.com/questions/10411616/grep-regex-not-containing-string)
```sh
grep ".*<word>.*"  -rnw . | grep -v ".*<word_to_exclude>.*"
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

### search file, but exclude some directories
```sh
grep <pattern> --exclude-dir=<directory-to-be-excluded> -rnw <directory>
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

### grep, case-insensitive
```sh
grep -i <pattern> -rnw . 
```

### grep, only list file names
```sh
grep <pattern> -rl .
```

### grep, list file not containing specific string
[How do I find files that do not contain a given string pattern?](https://stackoverflow.com/questions/1748129/how-do-i-find-files-that-do-not-contain-a-given-string-pattern)
```sh
grep <pattern> -rL .
```

### grep, limit number of files read 
[grep - limit number of files read](https://stackoverflow.com/questions/41402247/grep-limit-number-of-files-read)
```sh
grep <pattern> -r . | head -10
```

### grep the beginning of line
[Grep beginning of line](https://askubuntu.com/questions/639157/grep-beginning-of-line)
```sh
grep <^pattern> -r .
```

## awk
### cut a string and get the Nth part
```sh
echo "hello world, it's a good day" | awk '{print$3}'
# it's
```

### get the Nth line
```sh
awk 'NR==<line_number>' <filename>
```

### split lines in a file by a delimeter and print their Nth token
[How to get the first column of every line from a CSV file?](https://stackoverflow.com/questions/11668621/how-to-get-the-first-column-of-every-line-from-a-csv-file)

```sh
awk -F" " '{print $1}' <filename>
```

[Get last field using awk substr](https://stackoverflow.com/questions/17921544/get-last-field-using-awk-substr)

split lines by "/" and get the last token
```sh
awk -F "/" '{print $NF}' <filename>
```

### get length of lines in a file
```sh
awk '{ print length }' <filename>
```

### filter lines by their length
[How to remove lines shorter than XY?](https://unix.stackexchange.com/questions/123243/how-to-remove-lines-shorter-than-xy)
```sh
<other-command> | awk 'length($0) > <number>'
<other-command> | awk 'length($0) == <number>'
<other-command> | awk 'length($0) < <number>'
```

## split a file into two according to a ratio
[Split: how to split into different percentages?](https://unix.stackexchange.com/questions/10219/split-how-to-split-into-different-percentages)

The following split a file to 90% and 10%.
```sh
split -l $[ $(wc -l <filename>|cut -d" " -f1) * 90 / 100 ] <filename>
```

## find unique elements from other command's output
```sh
<other-command>| sort | uniq
```
Note that `sort` is required.

[sort command in unix with numeric sort](https://unix.stackexchange.com/questions/169200/sort-command-in-unix-with-numeric-sort)

If one want to do numeric sort(sort as numbers), then use `sort -V`.

[Sort and count number of occurrence of lines](https://unix.stackexchange.com/questions/170043/sort-and-count-number-of-occurrence-of-lines)

To also get their counts, use `uniq -c`. 

## create a .bak file for \<filename>
```sh
cp <filename>{,.bak}
```

## sed
To escape multiple leading spaces, add `\` before the first space.
### get the Nth line
```sh
sed -n <line_number>p <filename>
```
or
```sh
sed '<line_number>!d' <filename>
```

### remove the Nth line
[Delete specific line number(s) from a text file using sed?](https://stackoverflow.com/questions/2112469/delete-specific-line-numbers-from-a-text-file-using-sed)
```sh
sed -i -e '<start_line_number,end_line_number>d;<another_line_number>d' <filename>
```

### find and replace string
```sh
sed -i 's/<regular expression>/<replacement>/g' <filename>
```

### insert a line after Nth line(it will be N+1-th line)
```sh
sed -n -i 'p;<line_number>a <line_to_insert>' <filename>
```

### insert a line before first match
```sh
sed -i '/<line_to_match>/i <line_to_insert>' <filename>
```

### insert a line after first match
```sh
sed -i '/<line_to_match>/a <line_to_insert>' <filename>
```

### delete the \<N>-th line from outside the file
```sh
sed '<N> d' <filename>
```

### delete \<N> random lines from a file and output to another file
[How can I delete multiple random lines from a text file using sed?](https://unix.stackexchange.com/questions/244381/how-can-i-delete-multiple-random-lines-from-a-text-file-using-sed)

```sh
shuf -i1-$(wc -l < <input_file>) -n<N> | sed 's/$/d/' | sed -f- <input_file> > <output_file>
```

### remove part of a line 
```sh
sed -i 's/<word_to_delete>//' <filename>
```

### remove lines starting with a specific word
[How to delete a line with a given word using SED function](https://unix.stackexchange.com/questions/253055/how-to-delete-a-line-with-a-given-word-using-sed-function)
```sh
sed -i '/^<word>\b/d' <filename>
```

Input file:
```
a
a b
b a
ab
ad
b
```

Result file:
```
b a
ab
ad
b
```

### add prefix or suffix to all lines of a file
[Add a prefix string to beginning of each line](https://stackoverflow.com/questions/2099471/add-a-prefix-string-to-beginning-of-each-line)

This will edit the file in-place:
```sh
sed -i -e "s/^/<prefix>/" <filename>
sed -i -e "s/$/<suffix>/" <filename>
```
To create a new file:
```sh
sed -e "s/^/<prefix>/" <filename> > <newfilename>
sed -e "s/$/<suffix>/" <filename> > <newfilename>
```
Example: add current directory as prefix to a file
[How do I replace a token with the result of `pwd` in sed?](https://stackoverflow.com/questions/1186190/how-do-i-replace-a-token-with-the-result-of-pwd-in-sed)
```sh
sed -i -e "s?^?`pwd`/?" <filename>
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

## cut a file by \<delimiter> and get the specific \<fields>
```sh
cut -d '<delimiter>' -f <fields> <filename>
```

## cut by space and get the last element
```sh
<other-command> | rev | cut -d' ' -f1 | rev
```

## cut by space and remove the last element
[How to exclude last N columns in Bash on Linux?](https://www.systutorials.com/241478/how-to-exclude-last-n-columns-in-bash-on-linux/)
```sh
<other-command> | rev | cut -d ' ' -f2- | rev
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
[Shell重定向 ＆>file、2>&1、1>&2 、/dev/null的区别](https://blog.csdn.net/u011630575/article/details/52151995)
```sh
<some-command> > <filename.txt> 2>&1
```
0, 1, 2 here means standard input, standard output and standard error respectively.

`> <filename.txt>` means redirect standard output to the file.

`2>&1` means redirect standard error to standard output.

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

## compress to a tar.gz file, excluding some subfolders
```sh
tar -czf <parent.tar.gz> <parent> --exclude <parent>/<child1> --exclude <parent>/<child2>
```

## show progress bar while compressing to a tar.gz file
[Is there a way to see any tar progress per file?](https://superuser.com/questions/168749/is-there-a-way-to-see-any-tar-progress-per-file)
```sh
tar cf - <xxx> -P | pv -s $(du -sb <xxx> | awk '{print $1}') | gzip > <xxx>.tar.gz
```
Mac OS:
```sh
tar cf - <xxx> -P | pv -s $(($(du -sk <xxx> | awk '{print $1}') * 1024)) | gzip > <xxx>.tar.gz
```

## show progress bar while unzip a tar.gz file
```sh
pv <xxx.tar.gz> | tar xzf - -C </target/directory/to/unzip>
```

## extract .tar file
```sh
tar -xvf <xxx.tar>
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

## extract .bz2 file
[How to decompress a .bz2 file](https://superuser.com/questions/480950/how-to-decompress-a-bz2-file)
```sh
bzip2 -dk <xxx.bz2>
```

## go to the previous directory
```sh
cd -
```

## show difference between two files
```sh
diff <file1> <file2>
```

## show difference between two directories

[Given two directory trees, how can I find out which files differ?](https://stackoverflow.com/questions/4997693/given-two-directory-trees-how-can-i-find-out-which-files-differ)

```sh
diff -rq <dir1> <dir2>
```

`-r` for recursive, `-q` for short mode.


## show difference between two directories, exclude some files
```sh
diff -x "<pattern>" -r -q <dir1> <dir2>
```

## compare the two files
```sh
cmp <file1> <file2>
```
Sample output:
```
<file1> <file2> differ: byte 132161537, line 437952
```

## compare the two files, show the different byte position and their values
```sh
cmp -l <file1> <file2>
```
Sample output:
```sh
132161537 274   0
132161538   4   0
132161539 225   0
132161540 212   0
132161541 261   0
...
```

## compare the two so or executable files
[compare executable or object file](https://stackoverflow.com/questions/28808063/compare-executable-or-object-file)
```sh
diff <(objdump -d <file1>) <(objdump -d <file2>)
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
The `<target>` should be full path, otherwise there will be an error: `Too many levels of symbolic links`.

Difference of hard and soft link can be found in: [Linux ln command](https://www.computerhope.com/unix/uln.htm).

## check the target of a symbolic link
```bash
readlink <linkname>
```

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
find the difference set of \<file1> - \<file2>
```
comm -23 <(sort <file1>) <(sort <file2>)
```

find the intersection of \<file1> - \<file2>
```sh
comm -12 <(sort <file1>) <(sort <file2>)
```

Note that '<' and '(' should not be separated, otherwise there will be a ```bash: syntax error near unexpected token `('```!

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

## ls and then copy
[pass output as an argument for cp in bash [duplicate]](https://stackoverflow.com/questions/6833582/pass-output-as-an-argument-for-cp-in-bash)
```sh
cp `ls /source/directory` /target/directory
```

## ls and then delete
```sh
rm `ls /dirname/filename`
```

## copy : Argument list too long
[Argument list too long when copying files](https://askubuntu.com/questions/217764/argument-list-too-long-when-copying-files)

```bash
for i in *.jpg; do cp "$i" /target/directory; done
```

## copy only files with specific type and maintain the directory structure
[Copying only JPG from a directory structure to another location Linux](https://superuser.com/questions/91307/copying-only-jpg-from-a-directory-structure-to-another-location-linux)
```bash
rsync -av --include='*.<filetype>' --include='*/' --exclude='*' /src/dir /dst/dir
```

## move only files with specific type from a directory structure to another directory
```bash
find /src/dir -type f -name "*.<filetype>" -exec mv {} /dst/dir \;
```

## ls:  Argument list too long
[What is the fastest way in terminal to get a count of files when there is so many of them? [duplicate]](https://askubuntu.com/questions/1084737/what-is-the-fastest-way-in-terminal-to-get-a-count-of-files-when-there-is-so-man)

Use the following to replace `ls /dir/name/*.jpg | wc -l`
```bash
ls -l /dir/name | fgrep .jpg | wc -l
```

## alias: list alias set previously
```bash
alias
```

## alias: create a alias of a command
```bash
alias <dst_excutable>=<src_executable>
```
e.g.
```bash
alias python=python3
```

## rename a batch of files
[how can I rename multiple files by inserting a character?](https://unix.stackexchange.com/questions/33261/how-can-i-rename-multiple-files-by-inserting-a-character)

Rename file with extension `.cloud` to `_cloud.cpp`.
```bash
rename 's/.cloud$/_cloud.cpp/' *.cloud
```

Or using for loop and mv:

```sh
for f in $(ls *.xml); do
    mv "$f" "cam2_$f"
done
```
This replace `./FP32/b4/benchmark_CPU__.txt` to `./FP32/b4/benchmark_CPU_t1_s1.txt`:
```sh
for fname in $(grep FPS -rl . --include=*__.txt)
do
    mv "$fname" "${fname/__/_t1_s1}"
done
```

## combine files by column, and set the column width
[A better paste command](https://unix.stackexchange.com/questions/98945/a-better-paste-command)

```bash
paste <filename1> <filename2> ... <filenameN> | expand -t <column_width>
```

The above requires one to find `<column_width>` manually.
The following find the suitable `<column_width>` automatically.

```bash
paste <filename1> <filename2> ... <filenameN> | expand -t $(( $(wc -L < <filename1>) + 2 ))
```

## shuffle a file
```bash
shuf <filename>
```

## random sample from a file
[How to randomly sample a subset of a file](https://unix.stackexchange.com/questions/108581/how-to-randomly-sample-a-subset-of-a-file)

Sample `<count>` lines from `<filename>`.
```bash
shuf -n <count> <filename>
```

## random sample from a file(in-place)
```bash
shuf -n <count> <filename> -o <filename>
```

## to make core dumped into current directory
[Where do I find the core dump in ubuntu 16.04LTS?](https://askubuntu.com/questions/966407/where-do-i-find-the-core-dump-in-ubuntu-16-04lts)

[Core dumped, but core file is not in the current directory?](https://stackoverflow.com/questions/2065912/core-dumped-but-core-file-is-not-in-the-current-directory)

```bash
ulimit -c unlimited
echo "core.%e.%p" > /proc/sys/kernel/core_pattern 
sudo service apport start
```

Note: if you are inside a docker container, do the above on the HOST!

## use gdb to debug core file
[How do I analyze a program's core dump file with GDB when it has command-line parameters?](https://stackoverflow.com/questions/8305866/how-do-i-analyze-a-programs-core-dump-file-with-gdb-when-it-has-command-line-pa)

```bash
gdb <executable> <core_file>
```

or

```bash
gdb <executable> -c <core_file>
```

## open a file in read-only mode
```sh
view <filename>
```

## check if a directory exists
[Check if a directory exists in a shell script](https://stackoverflow.com/questions/59838/check-if-a-directory-exists-in-a-shell-script)
```sh
if [ -d "$DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY exists.
fi
```

```sh
if [ ! -d "$DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
fi
```

## for loop in bash
[Bash For Loop Examples](https://www.cyberciti.biz/faq/bash-for-loop/)
```bash
for OUTPUT in $(<other-command>)
do
   command1 on $OUTPUT
   command2 on $OUTPUT
   commandN
done
```

### continue
[Bash: Continue In a For / While Loop](https://www.cyberciti.biz/faq/unix-linux-bsd-appleosx-continue-in-bash-loop/)
```bash
for i in 1 2 3 4 5 6
do
    ### just skip printing $i; if it is 3 or 6  ###
    if [ $i -eq 3 -o $i -eq 6 ]
    then
        continue  ### resumes iteration of an enclosing for loop ###
    fi
    # print $i
    echo "$i"
done
```

## get video codec
[how to recognize video codec of a file with ffmpeg](https://stackoverflow.com/questions/2869281/how-to-recognize-video-codec-of-a-file-with-ffmpeg)
```sh
mediainfo --Inform="Video;%Codec%" <input_video>
# AVC
```

```sh
ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 <input_video>
# h264
```


## get video information
[How to retrieve video file information from command line under Linux?](https://superuser.com/questions/595177/how-to-retrieve-video-file-information-from-command-line-under-linux)
```sh
ffprobe -v error -show_format -show_streams <input_video>
```

## video convertion: mp4 to h264
[Converting .mp4 to .264 using FFmpeg](https://superuser.com/questions/1140237/converting-mp4-to-264-using-ffmpeg?answertab=votes#tab-top)
```sh
ffmpeg -i <input_mp4_video> -an -vcodec libx264 -crf 23 <output_h264_video>
```

## nano editor
First edit your file:
```sh
nano xxx.txt
```
Then press <kbd>Ctrl</kbd> + <kbd>O</kbd> to save, press <kbd>Enter</kbd> to confirm, and finally press <kbd>Ctrl</kbd> + <kbd>X</kbd> to exit.

## open folder from terminal
[How to open a folder in linux via terminal? [closed]](https://askubuntu.com/questions/464324/how-to-open-a-folder-in-linux-via-terminal)
```sh
nautilus <folder_name>
```

## open file from terminal
[How to open text, video, or picture files via terminal](https://askubuntu.com/questions/383997/how-to-open-text-video-or-picture-files-via-terminal/384003)
```sh
xdg-open <filename>
```

## find default video player's name
[Ubuntu (GNOME) default video player name](https://askubuntu.com/questions/1098203/ubuntu-gnome-default-video-player-name)

Find in launcher configuration file:
```sh
grep -r Videos /usr/share/applications
```
Sample output:
```
/usr/share/applications/org.gnome.Totem.desktop:Name=Videos
/usr/share/applications/totem.desktop:Name=Videos
```
Find out which package supplies this file:
```sh
dpkg -S /usr/share/applications/org.gnome.Totem.desktop
dpkg -S /usr/share/applications/totem.desktop
```
Sample output:
```
totem: /usr/share/applications/org.gnome.Totem.desktop
totem: /usr/share/applications/totem.desktop
```
So the default video player is `totem`.
