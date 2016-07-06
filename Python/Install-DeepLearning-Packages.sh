#!/bin/bash

# this script requires an existing installation of Anaconda Python


# supporting packages for Windows only
conda install LibPython
conda update libpython
conda install MinGW
conda update mingw


# CUDA
conda install CUDAToolkit
conda update cudatoolkit


# Theano
pip install --upgrade Theano --no-dependencies


# TensorFlow
conda install SetupTools
conda update setuptools

conda install Six
conda update six

conda install Wheel
conda update wheel

conda update numpy

pip uninstall protobuf   # a faulty version of ProtoBuf seems to cause problems
pip install https://storage.googleapis.com/tensorflow/mac/tensorflow-0.9.0-py2-none-any.whl


# GNumPy
pip install GNumPy


# install Deep Learning packages
pip install --upgrade Keras --no-dependencies
pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip --no-dependencies
pip install --upgrade git+git://github.com/hycis/Mozi.git --no-dependencies
pip install --upgrade NervanaNEON --no-dependencies
pip install --upgrade NeuralPy --no-dependencies
pip install --upgrade NeuroLab
pip install --upgrade NLPnet
pip install --upgrade NoLearn --no-dependencies
pip install --upgrade PyBrain
pip install --upgrade PyBrain2 --no-dependencies
pip install --upgrade PyDeepLearning --no-dependencies
pip install --upgrade PyDNN --no-dependencies
pip install --upgrade PythonBrain
pip install --upgrade SciKit-NeuralNetwork --no-dependencies
pip install --upgrade git+git://github.com/dougefr/synapyse.git
pip install --upgrade Theanets --no-dependencies
pip install --upgrade git+git://github.com/Samsung/veles.git
