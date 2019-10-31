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

### vim
```sh
apt-get install -y vim
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

### lspci
```sh
apt-get install pciutils
```

### cpio
```sh
apt-get install cpio
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

### OpenCV

#### apt
```sh
apt-get install -y libopencv-dev # this will install older version: 2.4.9.1
```
The installation path is: `/usr/share/OpenCV/`.

#### build from source
Follow the instruction here: [OpenCV Tutorials/Introduction to OpenCV/Installation in Linux](https://docs.opencv.org/3.4.6/d7/d9f/tutorial_linux_install.html)

First download opencv-x.x.x.zip and opencv_contrib-x.x.x.zip, and then unzip.

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
Add `OPENCV_EXTRA_MODULES_PATH` to build with modules from opencv_contrib.


Build:
```sh
make -j7
```

Install libraries:
```sh
sudo make install
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
First download TensorRT tar.gz file.
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
cd <TensorRT root directory>/samples/sampleMNIST && make
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

#### Convert YOLOv1 and YOLOv2 Models to the IR
Ref to the link: [Convert YOLOv1 and YOLOv2 Models to the IR](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_prepare_model_convert_model_tf_specific_Convert_YOLO_From_Tensorflow.html#convert_yolov1_and_yolov2_models_to_the_ir)

Based on `/opt/intel/openvino/deployment_tools/model_optimizer/extensions/front/tf/yolo_v2_voc.json`, write your own `yolo_v2_xxx.json`(revise `anchors` and `classes` based on your darknet cfg file)

and then:

```
cd /opt/intel/openvino/deployment_tools/model_optimizer
python3 ./mo_tf.py --input_model <tf_yolov2>.pb --batch 1  --tensorflow_use_custom_operations_config /opt/intel/openvino/deployment_tools/model_optimizer/extensions/front/tf/<custom_yolov2>.json
```

Then one can find `<tf_yolov2_pb_filename>.bin`, `<tf_yolov2_pb_filename>.mapping`, `<tf_yolov2_pb_filename>.xml` in `/opt/intel/openvino/deployment_tools/model_optimizer`.

#### Convert YOLOv3 Model to IR
Just follow the instruction here: [Convert YOLOv3 Model to IR](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_prepare_model_convert_model_tf_specific_Convert_YOLO_From_Tensorflow.html#yolov3-to-ir), the process is quite smooth.

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
