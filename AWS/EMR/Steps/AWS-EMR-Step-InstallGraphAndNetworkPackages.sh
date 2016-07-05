#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# change Home directory
export HOME=/mnt/home


# source script specifying environment variables
source ~/.EnvVars


# change directory to Programs directory
cd $APPS_DIR


# network analysis tools
sudo pip install --upgrade APGL
echo `df -h / | sed -n 2p` APGL >> $MAIN_DISK_USAGE_LOG

# (we skip installing Graph-Tool because it requires GCC C++ 14 compiler)
# wget https://downloads.skewed.de/graph-tool/graph-tool-2.12.tar.bz2
# tar jxf graph-tool-2.12.tar.bz2
# sudo rm graph-tool-2.12.tar.bz2
# cd graph-tool-*
# ./configure
# make
# sudo make install
# cd ..
# sudo rm -r graph-tool-*
# echo `df -h / | sed -n 2p` Graph-Tool >> $MAIN_DISK_USAGE_LOG

sudo yum install -y cairo cairo-devel
wget http://cairographics.org/releases/py2cairo-1.10.0.tar.bz2
tar jxf py2cairo-1.10.0.tar.bz2
sudo rm -r py2cairo-1.10.0.tar.bz2
cd py2cairo-1.10.0
./waf configure
./waf build
sudo ./waf install
cd ..
sudo rm -r py2cairo-1.10.0
echo `df -h / | sed -n 2p` Py2Cairo >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade GraphViz
echo `df -h / | sed -n 2p` GraphViz >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade NetworkX
echo `df -h / | sed -n 2p` NetworkX >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade PyGraphViz
echo `df -h / | sed -n 2p` PyGraphViz >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Python-iGraph
echo `df -h / | sed -n 2p` Python-iGraph >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade SNAPPy
echo `df -h / | sed -n 2p` SNAPPy >> $MAIN_DISK_USAGE_LOG
