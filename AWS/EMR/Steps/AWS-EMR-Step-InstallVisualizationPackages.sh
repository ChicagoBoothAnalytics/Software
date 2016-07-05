#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# change Home directory
export HOME=/mnt/home


# source script specifying environment variables
source ~/.EnvVars


# install advanced visualization tools
sudo pip install --upgrade Bokeh
echo `df -h / | sed -n 2p` Bokeh >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade GGPlot
echo `df -h / | sed -n 2p` GGplot >> $MAIN_DISK_USAGE_LOG
# sudo pip install --upgrade GNUPlot-Py --allow-external GNUPlot-Py --allow-unverified GNUPlot-Py   SKIPPED: cannot find

# brew install Expat
# brew install MakeDepend
# brew tap Homebrew/Science
# brew install --python --qt vtk5
# sudo pip install --upgrade MayaVi

sudo pip install --upgrade PyGAL
echo `df -h / | sed -n 2p` PyGAL >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Plotly
echo `df -h / | sed -n 2p` Plotly >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Cufflinks
echo `df -h / | sed -n 2p` Cufflinks >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Seaborn
echo `df -h / | sed -n 2p` Seaborn >> $MAIN_DISK_USAGE_LOG


# install R GGplot2
wget https://raw.githubusercontent.com/ChicagoBoothAnalytics/Software/master/R/Install-Visualization-Packages.R
dos2unix Install-Visualization-Packages.R
sudo Rscript Install-Visualization-Packages.R
sudo rm Install-Visualization-Packages.R
