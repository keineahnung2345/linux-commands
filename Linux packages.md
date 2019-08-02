# Linux packages
This README includes commands to install linux packages

## Ubuntu
### Search a package
```sh
apt search <package-name>
```

### find the installation directory of a package
```sh
dpkg -L <package-name>
```

### list a package's all available version
```sh
apt-cache madison <package-name>
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
apt-get install -y libopencv-dev # this will install older version: 2.4.9.1
```

The installation path is: `/usr/share/OpenCV/`.

### pip
```sh
apt install python3-pip
```

### glog
```sh
apt-get install -y libgoogle-glog-dev
```

### TensorRT
[Installing TensorRT: Using The NVIDIA Machine Learning Network Repo For Debian Installation](https://docs.nvidia.com/deeplearning/sdk/tensorrt-install-guide/index.html#maclearn-net-repo-install)
```sh
# Install the NVIDIA Machine Learning network repository installation package
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb
dpkg -i nvidia-machine-learning-repo-*.deb
apt-get update -y
# Install the TensorRT package that fits your particular needs
apt-get install libnvinfer5=5.1.5-1+cuda9.0     libnvinfer-dev=5.1.5-1+cuda9.0
# So TensorRT won't upgrade to a new version
apt-mark hold libnvinfer5 libnvinfer-dev
```

To check TensorRT version:

```sh
dpkg -l | grep nvinfer
```

or 

```sh
dpkg -l | grep TensorRT
```

### curl.h
[Installing curl.h library [duplicate]](https://askubuntu.com/questions/78183/installing-curl-h-library)
```sh
apt-get install libcurl4-openssl-dev
```

### libconfig.h++
```sh
apt-get install libconfig++8-dev
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
