#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# set CONSTANTS
export HOME=/mnt/home
export GITHUB_REPO_RAW_PATH=https://raw.githubusercontent.com/ChicagoBoothAnalytics/Software/master/AWS/EMR


# change directory to new Home
mkdir -p ~
cd ~


# start logging main disk usage
df -h / > /mnt/home/MainDiskUsage.log


# install DOS2UNIX utility
sudo yum install -y dos2unix
echo `df -h / | sed -n 2p` DOS2UNIX >> /mnt/home/MainDiskUsage.log


# download & source script specifying environment variables in Home directory
wget $GITHUB_REPO_RAW_PATH/.config/.EnvVars
dos2unix .EnvVars
source .EnvVars


# download additional Yum Repo specs files
cd /etc/yum.repos.d
sudo wget $GITHUB_REPO_RAW_PATH/YumRepos/fedora.repo
sudo wget $GITHUB_REPO_RAW_PATH/YumRepos/google-chrome.repo
sudo rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
echo `df -h / | sed -n 2p` YUM Repo Files >> $MAIN_DISK_USAGE_LOG
cd $APPS_DIR


# update existing Yum packages
sudo yum update -y
echo `df -h / | sed -n 2p` YUM Update All Packages >> $MAIN_DISK_USAGE_LOG


# install essential Development Tools
sudo yum groupinstall -y "Development Tools"
echo `df -h / | sed -n 2p` Development Tools >> $MAIN_DISK_USAGE_LOG


# install Performance Tools
sudo yum groupinstall -y "Performance Tools"
echo `df -h / | sed -n 2p` Performance Tools >> $MAIN_DISK_USAGE_LOG


# re-install compatible kernel source files
sudo yum erase -y kernel-devel
sudo yum install -y kernel-devel-$KERNEL_RELEASE
echo `df -h / | sed -n 2p` Kernel-Devel >> $MAIN_DISK_USAGE_LOG


# install C, C++ & ForTran compilers
sudo yum install -y gcc
sudo yum install -y gcc-c++
sudo yum install -y gcc-gfortran
echo `df -h / | sed -n 2p` Compilers >> $MAIN_DISK_USAGE_LOG


# install numerical libraries
sudo yum install -y atlas-devel
sudo yum install -y blas
sudo yum install -y blas-devel
sudo yum install -y lapack-devel
echo `df -h / | sed -n 2p` BLASes >> $MAIN_DISK_USAGE_LOG


# install Boost
sudo yum install -y boost
echo `df -h / | sed -n 2p` Boost >> $MAIN_DISK_USAGE_LOG


# install CMake
sudo yum install -y cmake
echo `df -h / | sed -n 2p` CMake >> $MAIN_DISK_USAGE_LOG


# install Git
sudo yum install -y git
echo `df -h / | sed -n 2p` Git >> $MAIN_DISK_USAGE_LOG


# install some other packages
sudo yum install -y cairo-devel
sudo yum install -y glib*
sudo yum install -y graphviz
sudo yum install -y graphviz-devel
sudo yum install -y libcurl-devel
sudo yum install -y libffi-devel
sudo yum install -y libjpeg-devel
sudo yum install -y libssh2-devel
sudo yum install -y libuuid-devel
sudo yum install -y libxml2-devel
sudo yum install -y ncurses-devel
sudo yum install -y openssl-devel
sudo yum install -y patch
sudo yum install -y zlib-devel
echo `df -h / | sed -n 2p` Misc. Packages >> $MAIN_DISK_USAGE_LOG


# install HDF5
sudo yum install -y http://www.hdfgroup.org/ftp/HDF5/current/bin/RPMS/hdf5-1.8.16-1.with.szip.encoder.el7.x86_64.rpm
sudo yum install -y http://www.hdfgroup.org/ftp/HDF5/current/bin/RPMS/hdf5-devel-1.8.16-1.with.szip.encoder.el7.x86_64.rpm
echo `df -h / | sed -n 2p` HDF5 >> $MAIN_DISK_USAGE_LOG


# install LibSodium
wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar xzf LATEST.tar.gz
sudo rm LATEST.tar.gz
cd libsodium-*
./configure --prefix=$SODIUM_DIR
make
sudo make install
export LDFLAGS=-lsodium
cd ..
sudo rm -r libsodium-*
echo `df -h / | sed -n 2p` LibSodium >> $MAIN_DISK_USAGE_LOG


# install ZeroMQ
git clone https://github.com/zeromq/libzmq
cd libzmq
./autogen.sh
./configure --prefix=$ZMQ_DIR
make
sudo make install
sudo ldconfig
cd ..
sudo rm -r libzmq
echo `df -h / | sed -n 2p` ZeroMQ >> $MAIN_DISK_USAGE_LOG


# install EPLL Release package
# ref: https://lambda-linux.io
curl -X GET -o RPM-GPG-KEY-lambda-epll https://lambda-linux.io/RPM-GPG-KEY-lambda-epll
sudo rpm --import RPM-GPG-KEY-lambda-epll
curl -X GET -o epll-release-2015.09-1.1.ll1.noarch.rpm https://lambda-linux.io/epll-release-2015.09-1.1.ll1.noarch.rpm
sudo yum install -y epll-release-2015.09-1.1.ll1.noarch.rpm
sudo rm RPM-GPG-KEY-lambda-epll
sudo rm epll-release-2015.09-1.1.ll1.noarch.rpm
echo `df -h / | sed -n 2p` EPLL >> $MAIN_DISK_USAGE_LOG


# install Firefox
# ref: https://lambda-linux.io/blog/2015/01/28/announcing-firefox-browser-support-for-amazon-linux
sudo yum --enablerepo=epll install -y firefox-compat
wget -O firefox-latest.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
bzcat firefox-latest.tar.bz2 | tar xvf -
sudo rm firefox-latest.tar.bz2
echo `df -h / | sed -n 2p` Firefox-Supporting Packages >> $MAIN_DISK_USAGE_LOG


# install LinuxBrew
git clone https://github.com/Homebrew/linuxbrew.git $LINUXBREW_HOME
sudo ln -s $(which gcc) `brew --prefix`/bin/gcc-$(gcc -dumpversion |cut -d. -f1,2)
sudo ln -s $(which g++) `brew --prefix`/bin/g++-$(g++ -dumpversion |cut -d. -f1,2)
sudo ln -s $(which gfortran) `brew --prefix`/bin/gfortran-$(gfortran -dumpversion |cut -d. -f1,2)


# make Python 2.7 default Python
sudo rm /usr/bin/python
sudo rm /usr/bin/pip
sudo ln -s /usr/bin/python2.7 /usr/bin/python
sudo ln -s /usr/bin/pip-2.7 /usr/bin/pip


# install basic Python packages

# Cython   SKIPPED: takes long
sudo pip install --upgrade Cython
# echo `df -h / | sed -n 2p` Cython >> $MAIN_DISK_USAGE_LOG

# FindSpark
sudo pip install --upgrade FindSpark
echo `df -h / | sed -n 2p` FindSpark >> $MAIN_DISK_USAGE_LOG

# H2O
sudo pip install --upgrade H2O
echo `df -h / | sed -n 2p` H2O >> $MAIN_DISK_USAGE_LOG

# PSutil
sudo pip install --upgrade PSutil
echo `df -h / | sed -n 2p` PSutil >> $MAIN_DISK_USAGE_LOG

# Py4J (for PySpark)
sudo pip install --upgrade Py4J
echo `df -h / | sed -n 2p` Py4J >> $MAIN_DISK_USAGE_LOG

# PySpark_CSV
wget https://raw.githubusercontent.com/seahboonsiew/pyspark-csv/master/pyspark_csv.py


# install Julia
wget https://junolab.s3.amazonaws.com/release/1.1.0/juno-linux-x64.zip
unzip juno-linux-x64.zip
sudo rm juno-linux-x64.zip
sudo ln -s $APPS_DIR/juno-linux64/resources/app/julia/bin/julia /usr/bin/julia
sudo ln -s $APPS_DIR/juno-linux64/resources/app/julia/bin/julia-debug /usr/bin/julia-debug


# install Scala
wget http://downloads.typesafe.com/scala/2.11.7/scala-2.11.7.tgz
tar xvf scala-*.tgz
sudo rm scala-*.tgz
sudo ln -s $APPS_DIR/scala-*/bin/fsc /usr/bin/fsc
sudo ln -s $APPS_DIR/scala-*/bin/scala /usr/bin/scala
sudo ln -s $APPS_DIR/scala-*/bin/scalac /usr/bin/scalac
sudo ln -s $APPS_DIR/scala-*/bin/scaladoc /usr/bin/scaladoc
sudo ln -s $APPS_DIR/scala-*/bin/scalap /usr/bin/scalap
