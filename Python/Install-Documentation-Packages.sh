#!/usr/bin/env bash

# this script requires an existing installation of Anaconda Python


# Read the Docs
pip install --upgrade ReCommonMark

conda install Sphinx_RtD_Theme
conda update sphinx_rtd_theme


# Sphinx
conda install Sphinx
conda update sphinx

pip install --upgrade Sphinx-AutoBuild
