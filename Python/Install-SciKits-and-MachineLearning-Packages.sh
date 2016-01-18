#!/bin/bash

# this script requires an existing installation of Anaconda Python


# install / upate certain popular SkiKits: http://scikits.appspot.com/scikits
conda update scikit-image
conda update scikit-learn
conda update statsmodels
pip install --upgrade TimeSeries


# install Natural Language Toolkit (NLtk)
conda update nltk


# install Machine Learning packages
pip install --upgrade MLpy --no-dependencies
conda install Orange
conda update orange
pip install --upgrade SKLearn-Pandas --no-dependencies
