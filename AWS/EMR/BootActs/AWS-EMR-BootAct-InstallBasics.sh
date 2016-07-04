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
echo `df -h / | sed -n 2p` YUM Repo Files >> $MAIN_DISK_USAGE_LOG
cd $APPS_DIR


# update existing Yum packages
sudo yum update -y
echo `df -h / | sed -n 2p` YUM Update All Packages >> $MAIN_DISK_USAGE_LOG


# install essential Development Libraries & Tools
sudo yum groupinstall -y --setopt=group_package_types=mandatory,default,optional "Development Libraries"
sudo yum groupinstall -y --setopt=group_package_types=mandatory,default,optional "Development Tools"
echo `df -h / | sed -n 2p` Development Libraries and Tools >> $MAIN_DISK_USAGE_LOG


# re-install compatible kernel source files
sudo yum erase -y kernel-devel
sudo yum install -y kernel-devel-$KERNEL_RELEASE
echo `df -h / | sed -n 2p` Kernel-Devel >> $MAIN_DISK_USAGE_LOG


# install C, C++ & ForTran compilers
# sudo yum install -y gcc gcc-c++ gcc-gfortran   # SKIPPED: already covered under Development Tools
# echo `df -h / | sed -n 2p` Compilers >> $MAIN_DISK_USAGE_LOG


# install scientific libraries
sudo yum groupinstall -y --setopt=group_package_types=mandatory,default,optional "Scientific Support"
sudo yum groupinstall -y --setopt=group_package_types=mandatory,default,optional "TeX Support"
# sudo yum install -y atlas atlas-devel blas blas-devel lapack lapack-devel   # SKIPPED: already covered under Scientific Support
echo `df -h / | sed -n 2p` Scientific Support >> $MAIN_DISK_USAGE_LOG


# install some other packages
sudo yum install -y cairo cairo-devel
sudo yum install -y glib*
sudo yum install -y graphviz graphviz-devel
sudo yum install -y libffi libffi-devel
sudo yum install -y libjpeg libjpeg-devel
sudo yum install -y libssh2 libssh2-devel
sudo yum install -y libuuid libuuid-devel
echo `df -h / | sed -n 2p` Misc. Packages >> $MAIN_DISK_USAGE_LOG


# install HDF5
sudo yum install -y https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.16/bin/RPMS/hdf5-1.8.16-1.with.szip.encoder.el7.x86_64.rpm https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.16/bin/RPMS/hdf5-devel-1.8.16-1.with.szip.encoder.el7.x86_64.rpm
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
wget https://github.com/zeromq/zeromq4-1/releases/download/v4.1.5/zeromq-4.1.5.tar.gz
tar xzf zeromq-*.tar.gz
sudo rm zeromq-*.tar.gz
cd zeromq-*
./autogen.sh
./configure --prefix=$ZMQ_DIR
make
sudo make install
sudo ldconfig
cd ..
sudo rm -r zeromq-*
echo `df -h / | sed -n 2p` ZeroMQ >> $MAIN_DISK_USAGE_LOG


# make Python 2.7 default Python
sudo rm /usr/bin/python
sudo rm /usr/bin/pip
sudo ln -s /usr/bin/python2.7 /usr/bin/python
sudo ln -s /usr/bin/pip-2.7 /usr/bin/pip


# install basic Python packages

# Cython
sudo pip install --upgrade Cython
echo `df -h / | sed -n 2p` Cython >> $MAIN_DISK_USAGE_LOG

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

# PyZMQ
sudo pip install --upgrade PyZMQ


# install R basics
wget https://raw.githubusercontent.com/ChicagoBoothAnalytics/Software/master/R/Install-Basic-Packages.R
sudo Rscript Install-Basic-Packages.R
sudo rm Install-Basic-Packages.R


# install Julia
wget https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4.6-linux-x86_64.tar.gz
tar xzf julia-*.tar.gz
sudo rm julia-*.tar.gz
sudo ln -s $APPS_DIR/julia-*/bin/julia /usr/bin/julia
sudo ln -s $APPS_DIR/julia-*/bin/julia-debug /usr/bin/julia-debug


# install Scala
wget http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz
tar xvf scala-*.tgz
sudo rm scala-*.tgz
sudo ln -s $APPS_DIR/scala-*/bin/fsc /usr/bin/fsc
sudo ln -s $APPS_DIR/scala-*/bin/scala /usr/bin/scala
sudo ln -s $APPS_DIR/scala-*/bin/scalac /usr/bin/scalac
sudo ln -s $APPS_DIR/scala-*/bin/scaladoc /usr/bin/scaladoc
sudo ln -s $APPS_DIR/scala-*/bin/scalap /usr/bin/scalap
