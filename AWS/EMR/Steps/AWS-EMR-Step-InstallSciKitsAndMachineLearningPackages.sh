#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# install certain popular SkiKits: http://scikits.appspot.com/scikits
sudo pip install --upgrade SciKit-Image
sudo pip install --upgrade SciKit-Learn
sudo pip install --upgrade StatsModels
sudo pip install --upgrade TimeSeries


# install Natural Language Toolkit (NLtk)
sudo pip install --upgrade NLtk


# install Machine Learning packages
sudo pip install --upgrade MLpy
# sudo pip install --upgrade Orange   takes long
sudo pip install --upgrade SKLearn-Pandas
sudo pip install --upgrade Sparkit-Learn
