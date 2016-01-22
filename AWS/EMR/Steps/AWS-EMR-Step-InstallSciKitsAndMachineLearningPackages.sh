#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# change Home directory
export HOME=/mnt/home


# source script specifying environment variables
source ~/.EnvVars


# install certain popular SkiKits: http://scikits.appspot.com/scikits
sudo pip install --upgrade SciKit-Image
echo `df -h / | sed -n 2p` SciKit-Image >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade SciKit-Learn
echo `df -h / | sed -n 2p` SciKit-Learn >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade StatsModels
echo `df -h / | sed -n 2p` StatsModels >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade TimeSeries
echo `df -h / | sed -n 2p` TimeSeries >> $MAIN_DISK_USAGE_LOG


# install Natural Language Toolkit (NLtk)
sudo pip install --upgrade NLtk
echo `df -h / | sed -n 2p` NLtk >> $MAIN_DISK_USAGE_LOG


# install Machine Learning packages
sudo pip install --upgrade MLpy
echo `df -h / | sed -n 2p` MLpy >> $MAIN_DISK_USAGE_LOG

# sudo pip install --upgrade Orange   SKIPPED: takes long
# echo `df -h / | sed -n 2p` Orange >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade SKLearn-Pandas
echo `df -h / | sed -n 2p` SKLearn-Pandas >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Sparkit-Learn
echo `df -h / | sed -n 2p` Sparkit-Learn >> $MAIN_DISK_USAGE_LOG
