#!bin/bash

# this script requires an existing installation of Anaconda Python


# Bokeh
conda update bokeh


# GGplot
pip install --upgrade Brewer2MPL
pip install --upgrade GGplot --no-dependencies


# Plotly
pip install --upgrade Plotly
pip install --upgrade Cufflinks --no-dependencies


# Seaborn
conda install Seaborn
conda update seaborn
