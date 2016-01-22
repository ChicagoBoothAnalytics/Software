#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# install advanced visualization tools
sudo pip install --upgrade Bokeh
echo `df -h /` Bokeh >> $MAIN_DISK_USAGE_LOG
sudo pip install --upgrade GGPlot
echo `df -h /` GGplot >> $MAIN_DISK_USAGE_LOG
# sudo pip install --upgrade GNUPlot-Py --allow-external GNUPlot-Py --allow-unverified GNUPlot-Py   SKIPPED: cannot find

# brew install Expat
# brew install MakeDepend
# brew tap Homebrew/Science
# brew install --python --qt vtk5
# sudo pip install --upgrade MayaVi

sudo pip install --upgrade PyGAL
echo `df -h /` PyGAL >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Plotly
echo `df -h /` Plotly >> $MAIN_DISK_USAGE_LOG
sudo pip install --upgrade Cufflinks
echo `df -h /` Cufflinks >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Seaborn
echo `df -h /` Seaborn >> $MAIN_DISK_USAGE_LOG
