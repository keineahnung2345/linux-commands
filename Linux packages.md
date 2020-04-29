# Linux packages
This README includes commands to install linux packages

Useful links: [How to Install](https://www.howtoinstall.co/en/)

## Ubuntu
### Recover the system after executing autoremove
If you execute `sudo apt-get autoremove --purge` accidently, the computer may crash.(No desktop to show)

Ref to [Ubuntu 14.04 差点重装，崩溃！](https://blog.csdn.net/lhl_blog/article/details/39455523), one can execute the following to bring the desktop back!
```sh
apt-get install ubuntu-desktop
apt-get install unity
apt-get install unity-common
apt-get install unity-lens*
apt-get install unity-services
apt-get install unity-asset-pool
reboot
```

### add-apt-repository
```sh
apt-get install -y software-properties-common python-software-properties
```

### remove package causing error when apt-get update
Ref to [remove packages with error on apt-get update [duplicate]](https://askubuntu.com/questions/810771/remove-packages-with-error-on-apt-get-update)

The error message when executing `apt-get update`:
```
Get:1 file:/var/cuda-repo-10-0-local-10.0.130-410.48  InRelease
Ign:1 file:/var/cuda-repo-10-0-local-10.0.130-410.48  InRelease
Get:2 file:/var/cuda-repo-10-1-local-10.1.243-418.87.00  InRelease
Ign:2 file:/var/cuda-repo-10-1-local-10.1.243-418.87.00  InRelease
Get:3 file:/var/nv-tensorrt-repo-cuda10.1-trt6.0.1.5-ga-20190913  InRelease
Ign:3 file:/var/nv-tensorrt-repo-cuda10.1-trt6.0.1.5-ga-20190913  InRelease
Get:4 file:/var/cuda-repo-10-0-local-10.0.130-410.48  Release
Err:4 file:/var/cuda-repo-10-0-local-10.0.130-410.48  Release
  File not found - /var/cuda-repo-10-0-local-10.0.130-410.48/Release (2: No such file or directory)
Get:5 file:/var/cuda-repo-10-1-local-10.1.243-418.87.00  Release [574 B]
Get:6 file:/var/nv-tensorrt-repo-cuda10.1-trt6.0.1.5-ga-20190913  Release [574 B]
Get:5 file:/var/cuda-repo-10-1-local-10.1.243-418.87.00  Release [574 B]
Get:6 file:/var/nv-tensorrt-repo-cuda10.1-trt6.0.1.5-ga-20190913  Release [574 B]
Ign:9 http://dl.google.com/linux/chrome/deb stable InRelease                                    
Hit:10 http://archive.ubuntukylin.com:10006/ubuntukylin xenial InRelease                        
Hit:11 http://dl.google.com/linux/chrome/deb stable Release                                     
Hit:13 http://packages.microsoft.com/repos/vscode stable InRelease                              
Hit:15 http://security.ubuntu.com/ubuntu xenial-security InRelease                              
Hit:16 http://cn.archive.ubuntu.com/ubuntu xenial InRelease                                     
Hit:17 http://cn.archive.ubuntu.com/ubuntu xenial-updates InRelease                             
Hit:18 http://cn.archive.ubuntu.com/ubuntu xenial-backports InRelease                           
Hit:19 http://ppa.launchpad.net/apt-fast/stable/ubuntu xenial InRelease                         
Hit:20 http://ppa.launchpad.net/graphics-drivers/ppa/ubuntu xenial InRelease   
Hit:21 http://ppa.launchpad.net/webupd8team/java/ubuntu xenial InRelease       
Hit:22 http://ppa.launchpad.net/yannubuntu/boot-repair/ubuntu xenial InRelease 
Ign:12 https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1604/x86_64  InRelease
Hit:23 https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1604/x86_64  Release
Reading package lists... Done
E: The repository 'file:/var/cuda-repo-10-0-local-10.0.130-410.48  Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```
We need to find where does the info of `cuda-repo-10-0` be stored:
```sh
cd /etc/apt
grep -ir cuda-repo-10-0
```
It outputs:
```
sources.list.d/cuda-10-0-local-10.0.130-410.48.list:deb file:///var/cuda-repo-10-0-local-10.0.130-410.48 /
sources.list.d/cuda-10-0-local-10.0.130-410.48.list.save:deb file:///var/cuda-repo-10-0-local-10.0.130-410.48 /
```
Edit the two files `sources.list.d/cuda-10-0-local-10.0.130-410.48.list` and `sources.list.d/cuda-10-0-local-10.0.130-410.48.list.save`, and comment their contents.

After that, `apt-get update` can be executed successfully.

### apt-fast
[apt-fast](https://github.com/ilikenwf/apt-fast)
```sh
add-apt-repository ppa:apt-fast/stable
apt-get update
apt-get -y install apt-fast
```

There will be 3 questions, answer as follow:
```
Configuring apt-fast
--------------------

  1. apt-get  2. apt  3. aptitude
Package manager to install and remove software: 1                               

Stored in ${_MAXNUM} variable.

Maximum number of connections: 8

This does not affect package manager dialog but download installable packages before package
manager confirmation.

Suppress apt-fast confirmation dialog? [yes/no] yes
```

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

### sudo
```sh
apt-get install -y sudo
```

### sshpass
[How to pass password to scp?](https://stackoverflow.com/questions/50096/how-to-pass-password-to-scp)
```sh
apt install sshpass
```

### vim
```sh
apt-get install -y vim
```

### curl
```sh
apt-get install -y curl
```

### less
```sh
apt-get install -y less
```

### ps, kill
```sh
apt-get install -y procps
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

### glxinfo
[glxinfo: command not found .... nvidia debian](https://www.linuxquestions.org/questions/debian-26/glxinfo-command-not-found-nvidia-debian-469088/)
```sh
apt-get install -y mesa-utils
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
Before installing `cmake`, it's required to install `openssl`.

```sh
apt-get install -y cmake
```
To install newer version of `cmake`, follows [How do I install the latest version of cmake from the command line?](https://askubuntu.com/a/865294/913680)

### gcc, g++, make
```sh
apt-get install -y build-essential
```
Use `gcc -v`, `g++ --version` and `make -v` to check their versions.

### dlocate
```sh
apt-get install -y dlocate
```

### python
```sh
apt-get install python3
```

### java
[How to Install JAVA 8 on Ubuntu 18.04/16.04, Linux Mint 19/18](https://tecadmin.net/install-oracle-java-8-ubuntu-via-ppa/)
```sh
apt install -y openjdk-8-jdk openjdk-8-jre
```

Set environment variable, in `~/.bashrc`:
```
export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"
export PATH=$PATH:$JAVA_HOME/bin
```

### pip
```sh
apt install python3-pip
```

### glog
```sh
apt-get install -y libgoogle-glog-dev
```

### gtest(Googletest)
[Cartexius/install_gtest_ubuntu.md](https://gist.github.com/Cartexius/4c437c084d6e388288201aadf9c8cdd5)
```sh
# this only download google/googletest's source code, not install it!
sudo apt-get install libgtest-dev
# the source code is put here
cd /usr/src/gtest
mkdir build && cd build
sudo cmake ..
sudo make
sudo cp *.a /usr/lib
mkdir /usr/local/lib/gtest
sudo ln -s /usr/lib/libgtest.a /usr/local/lib/gtest/libgtest.a
sudo ln -s /usr/lib/libgtest_main.a /usr/local/lib/gtest/libgtest_main.a
```

### gflags
```sh
apt-get install -y libgflags-dev
```

### lspci
```sh
apt-get install pciutils
```

### cpio
```sh
apt-get install cpio
```

### openssl
[How do I install the OpenSSL libraries on Ubuntu?](https://stackoverflow.com/questions/3016956/how-do-i-install-the-openssl-libraries-on-ubuntu)
```sh
apt-get install libssl-dev
```
Check version:
```
openssl version -a
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

### pkg-config
```sh
apt-get install -y pkg-config
```

[CMAKE Could NOT find PkgConfig (missing: PKG_CONFIG_EXECUTABLE)](https://askubuntu.com/questions/717302/cmake-could-not-find-pkgconfig-missing-pkg-config-executable): This can solve `Could NOT find PkgConfig (missing: PKG_CONFIG_EXECUTABLE)` when running cmake.

### mysql/mysql.h
[mysql.h file can't be found](https://stackoverflow.com/questions/14604228/mysql-h-file-cant-be-found/20634454)
```sh
apt-get install -y libmysqlclient-dev
```
mysql.h will be located at /usr/include/mysql/.

### boost
```sh
apt-get install libboost-all-dev
```

### cuda

#### Uninstall
[How to uninstall CUDA Toolkit and cuDNN under Linux?](https://devtalk.nvidia.com/default/topic/994466/how-to-uninstall-cuda-toolkit-and-cudnn-under-linux-/)

[How to uninstall Cuda7.5 from ubuntu?](https://stackoverflow.com/questions/39351244/how-to-uninstall-cuda7-5-from-ubuntu)

Add the following:
```sh
sudo apt-get --purge -y remove 'cuda*'
sudo reboot
```

### gtk+ 3.0
[How do I Install GTK+ 3.0?](https://askubuntu.com/questions/101306/how-do-i-install-gtk-3-0)
```sh
apt-get install libgtk-3-dev
```

### ffmpeg
```sh
apt-get install -y ffmpeg
```

### mediainfo
```sh
apt-get install -y mediainfo
```

### vlc player
[How to Install Latest VLC in Ubuntu Linux](https://itsfoss.com/install-latest-vlc/)
```sh
snap install vlc
```

### ssh server
[Ubuntu Linux install OpenSSH server](https://www.cyberciti.biz/faq/ubuntu-linux-install-openssh-server/)
```sh
apt-get install -y openssh-server
```
Verify that ssh service running:
```sh
systemctl status ssh
```

### intel_gpu_top, intel_gpu_time, intel_gpu_frequency, intel_gpu_abrt
```sh
apt-get install intel-gpu-tools
```

### git-lfs
[git-lfs installation](https://github.com/git-lfs/git-lfs/wiki/Installation)
```sh
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
git lfs install
```

### zlib
[Configure error: could not find the zlib library](https://askubuntu.com/questions/1169754/configure-error-could-not-find-the-zlib-library)
```sh
apt-get install zlib1g-dev
```

### HDF5
[How to check if HDF5 is installed?](https://unix.stackexchange.com/questions/287974/how-to-check-if-hdf5-is-installed)

```sh
apt-get install -y libhdf5-dev
```

### Latex
[How to install LaTex on Ubuntu 18.04 Bionic Beaver Linux](https://linuxconfig.org/how-to-install-latex-on-ubuntu-18-04-bionic-beaver-linux)
```sh
apt-get install -y texlive-latex-extra
```

### OpenCV

#### apt
```sh
apt-get install -y libopencv-dev # this will install older version: 2.4.9.1
```
The installation path is: `/usr/share/OpenCV/`.

#### build from source
Follow the instruction here: [OpenCV Tutorials/Introduction to OpenCV/Installation in Linux](https://docs.opencv.org/3.4.6/d7/d9f/tutorial_linux_install.html)

Prerequistie: python3 and numpy
```sh
apt-get install -y python3-dev
apt-get install -y python3-pip
python3 -m pip install numpy
```

Prerequisite for `highgui`:
```sh
apt-get install -y libgtk2.0-dev pkg-config
```

First download opencv-x.x.x.zip from [OpenCV - Releases](https://opencv.org/releases/) and opencv_contrib-x.x.x.zip from [opencv/opencv_contrib - Releases](https://github.com/opencv/opencv_contrib/releases), and then unzip.

Create directory:
```sh
cd ~/opencv
mkdir build
cd build
```

Configure:
```sh
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local OPENCV_EXTRA_MODULES_PATH=/xxx/opencv_contrib-3.4.1/modules ..
```

From [Build specific modules OpenCV](https://stackoverflow.com/questions/25594003/build-specific-modules-opencv), to only install some modules, one can specify `-DBUILD_LIST=...`:
```sh
-DBUILD_LIST=core,improc,imgcodecs,dnn,videoio,cudev,highgui
```
To determine which modules are required, one should check one's source code and find the opencv headers included, for me, they are:
```cpp
#include <opencv2/opencv.hpp>
#include <opencv2/core/types.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/dnn/dnn.hpp>
#include <opencv2/videoio.hpp>
```
Note that `cudev` and `highgui` are not directly included, but they are required because `cudev` is for gpu programming and `highgui` is for the user interface window.

After specifying `-DBUILD_LIST=...`, part of `cmake`'s output would be:
```
--     Disabled by dependency:      calib3d cudaarithm cudabgsegm cudacodec cudafeatures2d cudafilters cudaimgproc cudalegacy cudaobjdetect cudaoptflow cudastereo cudawarping features2d flann ml objdetect photo python2 python_bindings_generator shape stitching superres ts video videostab viz
```

Add `OPENCV_EXTRA_MODULES_PATH` to build with modules from opencv_contrib.

Build:
```sh
make -j$(nproc)
```

Install libraries:
```sh
sudo make install
```

Setting environment variables:
```sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
```

To uninstall, go to the build directory, and then:
```sh
sudo make uninstall
```

One still needs to delete the following directories:
```
rm `ls /usr/local/lib/*opencv*so*` #remove dead softlinks
rm -r /usr/local/lib/opencv4
rm -r /usr/local/include/opencv4
rm -r /usr/local/share/opencv4
```

### TensorRT
[Installing TensorRT: Using The NVIDIA Machine Learning Network Repo For Debian Installation](https://docs.nvidia.com/deeplearning/sdk/tensorrt-install-guide/index.html#maclearn-net-repo-install)

#### Debian Installation
Setup repo:
```sh
# Install the NVIDIA Machine Learning network repository installation package
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb
dpkg -i nvidia-machine-learning-repo-*.deb
```
If it outputs the following error message:
```
gpg: no valid OpenPGP data found.
Failed to add GPGKEY at http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/7fa2af80.pub to apt keys.
```
Then try:
```sh
wget https://developer.download.nvidia.cn/compute/machine-learning/repos/ubuntu1604/x86_64/7fa2af80.pub -O 7fa2af80.pub
chmod 755 7fa2af80.pub
```
Continue to install TensorRT:
```sh
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

#### Tar File Installation
First download TensorRT tar.gz file from [NVIDIA TensorRT](https://developer.nvidia.com/tensorrt).
```sh
tar xzvf TensorRT-5.1.x.x.<os>.<arch>-gnu.cuda-x.x.cudnn7.x.tar.gz
```
Add the following line into `~/.bashrc`:
```sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:<eg:TensorRT-5.1.x.x/lib>
```
And then:
```sh
source ~/.bashrc
```
Test, follow the instruction [here](https://docs.nvidia.com/deeplearning/sdk/tensorrt-sample-support-guide/index.html#mnist_sample):
```sh
cd <TensorRT root directory>/samples && make
# download 0.pgm ~ 9.pgm
cd <TensorRT root directory>/data/mnist && python3 download_pgms.py
cd <TensorRT root directory>/bin && ./sample_mnist
```

### OpenVINO
Follow the instruction here: [Install Intel® Distribution of OpenVINO™ toolkit for Linux*](https://docs.openvinotoolkit.org/latest/_docs_install_guides_installing_openvino_linux.html)

Download `l_openvino_toolkit_p_2019.3.376.tgz` from https://software.intel.com/en-us/openvino-toolkit/choose-download/free-download-linux.

#### Unzip and install:
```sh
tar -xzf l_openvino_toolkit_p_2019.3.376.tgz
cd l_openvino_toolkit_p_2019.3.376
apt-get update -y
# these are the packages needed during installation
apt-get install -y pciutils cpio python3 sudo cmake
./install.sh
```

#### Install External Software Dependencies:
```sh
cd /opt/intel/openvino/install_dependencies
sudo -E ./install_openvino_dependencies.sh
```

#### Install NEO OCL driver:
[Assign to GPU Failed](https://software.intel.com/en-us/forums/intel-distribution-of-openvino-toolkit/topic/780703#comment-1927023)

This is required if you want to run on Intel GPU!
```sh
cd /opt/intel/openvino/install_dependencies
./install_NEO_OCL_driver.sh
sudo usermod -a -G video USERNAME
```
If this is not installed, trying to run on GPU will generate the following error!
```
[ ERROR ] Failed to create plugin /opt/intel/openvino_2019.3.376/deployment_tools/inference_engine/lib/intel64/libclDNNPlugin.so for device GPU
Please, check your environment
clGetPlatformIDs error -1001
```

#### Set the Environment Variables:
add the following into `~/.bashrc`:
```sh
source /opt/intel/openvino/bin/setupvars.sh
```
and then `source ~/.bashrc`.

#### Configure the Model Optimizer(TensorFlow)
```sh
# first install python tensorflow
python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple tensorflow
cd /opt/intel/openvino/deployment_tools/model_optimizer/install_prerequisites
sudo ./install_prerequisites_tf.sh
```

#### Run the Verification Scripts to Verify Installation
```sh
cd /opt/intel/openvino/deployment_tools/demo
# Image Classification verification script
./demo_squeezenet_download_convert_run.sh
# Inference Pipeline verification script
./demo_security_barrier_camera.sh
```

#### Uninstall
[Uninstall OpenVINO completely from Ubuntu machine](https://software.intel.com/en-us/forums/intel-distribution-of-openvino-toolkit/topic/814827)
```sh
cd /opt/intel/openvino/openvino_toolkit_uninstaller
sudo ./uninstall.sh
```

### Android SDK
[How to install Android SDK on Ubuntu?](https://stackoverflow.com/a/53508177/10651567)

Download `sdk-tools-linux-4333796.zip` from [android studio - Command line tools only](https://developer.android.com/studio)

Unzip it to an appropiate location, the resulting directory is `tools`.

```
mkdir android-sdk
mv tools android-sdk
```


### Android NDK
Download the zip file from https://developer.android.com/ndk/downloads.

Unzip it to an appropiate location.

Update environment variables, in `/etc/profile`, add:
```bash
export ANDROID_NDK_HOME=/home/jian/Documents/installation/android-ndk-r20
export PATH=$ANDROID_NDK_HOME:$PATH
```

### Protocol Buffers
First download the required version from https://github.com/protocolbuffers/protobuf/tags (here I download v2.6.1 because TensorRT uses proto2).
```sh
tar -xzf v2.6.1.tar.gz
```
And you will get a folder `protobuf-2.6.1`.

Since the link of googletest in `./autogen.sh` is broken, we need to download it ourselves.
Download googletest from https://github.com/google/googletest/releases (here I download release-1.5.0 because proto buffers v2.6.1 requires it).
```sh
tar -xzf release-1.5.0.tar.gz
# got folder: googletest-release-1.5.0
mv googletest-release-1.5.0 protobuf-2.6.1/gtest
```
Then following the [official instruction](https://github.com/protocolbuffers/protobuf/tree/master/src):
```sh
./autogen.sh
./configure
make
make check
sudo make install
sudo ldconfig # refresh shared library cache.
```
To generate c++ code:
```sh
protoc --cpp_out=`pwd` <your_file>.proto
```
It will generate `<your_file>.pb.cc` and `<your_file>.pb.h`.

For more: check the [developer guide](https://developers.google.com/protocol-buffers/docs/proto#specifying-field-rules).

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
