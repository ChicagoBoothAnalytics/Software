#!/bin/bash

# this script requires an existing installation of Anaconda Python


conda update conda


# Anaconda Accelerate
# ref: http://docs.continuum.io/accelerate
conda install Accelerate
conda update accelerate


# IOPro
conda install IOPro
conda update iopro


# Intel Math Kernel Library (MKL)
conda install MKL
conda update mkl


# Numba / NumbaPro
conda install Numba
conda update numba
conda install NumbaPro
conda update numbapro
