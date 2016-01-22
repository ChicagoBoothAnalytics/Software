#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# change Home directory
export HOME=/mnt/home


# source script specifying environment variables
source ~/.EnvVars


# install certain popular SkiKits: http://scikits.appspot.com/scikits
sudo pip install --upgrade SciKit-Image
echo `df -h /` SciKit-Image >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade SciKit-Learn
echo `df -h /` SciKit-Learn >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade StatsModels
echo `df -h /` StatsModels >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade TimeSeries
echo `df -h /` TimeSeries >> $MAIN_DISK_USAGE_LOG


# install Natural Language Toolkit (NLtk)
sudo pip install --upgrade NLtk
echo `df -h /` NLtk >> $MAIN_DISK_USAGE_LOG


# install Machine Learning packages
sudo pip install --upgrade MLpy
echo `df -h /` MLpy >> $MAIN_DISK_USAGE_LOG

# sudo pip install --upgrade Orange   SKIPPED: takes long
# echo `df -h /` Orange >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade SKLearn-Pandas
echo `df -h /` SKLearn-Pandas >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Sparkit-Learn
echo `df -h /` Sparkit-Learn >> $MAIN_DISK_USAGE_LOG
