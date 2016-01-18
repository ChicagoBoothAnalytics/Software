#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# change Home directory
export HOME=/mnt/home


# source script specifying environment variables
source ~/.EnvVars


# install ChicagoBoothML Helpy package
cd $PROGRAMS_DIR
git clone https://github.com/ChicagoBoothML/Helpy.git
cd Helpy
sudo python setup.py develop
cd ..
