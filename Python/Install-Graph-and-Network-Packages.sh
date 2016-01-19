#!/bin/bash

# this script requires an existing installation of Anaconda Python


pip install --upgrade APGL --no-dependencies

conda install GraphViz
conda update graphviz

conda install NetworkX
conda update networkx

# pip install --upgrade PyGraphViz   SKIP: requires C++
# pip install --upgrade Python-iGraph   SKIP: requires many other dependencies
# pip install --upgrade SNAPPy   SKIP: requires many other dependencies
