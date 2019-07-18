# Linux packages
This README includes commands to install linux packages

## Ubuntu
### Search a package
```sh
apt search <package-name>
```

### ifconfig, netstat
```sh
apt-get install -y net-tools
```

### ip
```sh
apt-get install -y iproute iproute-doc
```

### 7za
```sh
apt-get install -y p7zip-full
```

### lsb_release
```sh
apt-get install -y lsb-release
```

### nvcc
```sh
apt install -y nvidia-cuda-toolkit
```

### zip, unzip
```sh
apt-get install -y zip unzip
```

### bunzip2
```sh
apt-get install -y bzip2
```

### ab
```sh
apt-get install -y apache2-utils
```

### ascii2uni
```sh
apt-get install -y uni2ascii
```

### cmake
```sh
apt-get install -y cmake
```

### gcc, make
```sh
apt-get install -y build-essential
```
Use `gcc -v` and `make -v` to check their versions.

### OpenCV
Follow the instruction here: [OpenCV Tutorials/Introduction to OpenCV/Installation in Linux](https://docs.opencv.org/3.4.6/d7/d9f/tutorial_linux_install.html)
```sh
apt-get install -y libopencv-dev # this will install older version
```

### pip
```sh
apt install python3-pip
```

### glog
```sh
apt-get install -y libgoogle-glog-dev
```

## CentOS
### facter
```sh
yum install -y facter
```

### locate
```sh
yum install -y mlocate
```

### ip
```sh
yum install -y iproute iproute-doc
```

### bunzip2
```sh
yum install -y bzip2
```

### ab
```sh
yum install -y httpd-tools
```
