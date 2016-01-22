#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# change Home directory
export HOME=/mnt/home


# source script specifying environment variables
source ~/.EnvVars


# change directory to Programs directory
cd $APPS_DIR


# install Geos, Proj, Basemap, Google Maps API & other geospatial libraries
git clone https://github.com/matplotlib/basemap.git
cd basemap/geos-*
./configure --prefix=$GEOS_DIR
make
sudo make install
cd ..
sudo python setup.py install
cd ..
sudo rm -r basemap
echo `df -h /` Basemap >> $MAIN_DISK_USAGE_LOG

wget http://download.osgeo.org/proj/proj-4.8.0.tar.gz
tar xzf proj-4.8.0.tar.gz
sudo rm proj-4.8.0.tar.gz
cd proj-4.8.0
./configure --prefix=$PROJ_DIR
make
sudo make install
cd ..
sudo rm -r proj-4.8.0
echo `df -h /` Proj >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Descartes
echo `df -h /` Descartes >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Google-API-Python-Client
echo `df -h /` Google-API-Python-Client >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade GoogleMaps
echo `df -h /` GoogleMaps >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade PyProj
echo `df -h /` PyProj >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade PySAL
echo `df -h /` PySAL >> $MAIN_DISK_USAGE_LOG

# brew install gdal
# sudo pip install --upgrade Fiona   # depends on GDAL
# sudo pip install --upgrade Cartopy   # canno detect Proj4.8
# sudo pip install --upgrade Kartograph    # not yet released
