#!/bin/bash

# this script requires an existing installation of Anaconda Python


# update iPython / Jupyter
conda update ipython
conda update jupyter

# Jupyter NbExtensions Configurator
pip install --upgrade Jupyter_NbExtensions_Configurator

# iPython Notebook Extensions
pip install https://github.com/ipython-contrib/IPython-notebook-extensions/tarball/master

# update NBConvert
conda update nbconvert

# RunIPy
conda install RunIPy
conda update runipy
