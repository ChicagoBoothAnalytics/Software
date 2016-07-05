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
echo `df -h / | sed -n 2p` Basemap >> $MAIN_DISK_USAGE_LOG

wget http://download.osgeo.org/proj/proj-4.9.2.tar.gz
tar xzf proj-*.tar.gz
sudo rm proj-*.tar.gz
cd proj-*
./configure --prefix=$PROJ_DIR
make
sudo make install
cd ..
sudo rm -r proj-*
echo `df -h / | sed -n 2p` Proj >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Descartes
echo `df -h / | sed -n 2p` Descartes >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade Google-API-Python-Client
echo `df -h / | sed -n 2p` Google-API-Python-Client >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade GoogleMaps
echo `df -h / | sed -n 2p` GoogleMaps >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade PyProj
echo `df -h / | sed -n 2p` PyProj >> $MAIN_DISK_USAGE_LOG

sudo pip install --upgrade PySAL   # SKIPPED: somehow this makes GPU master node hang...
echo `df -h / | sed -n 2p` PySAL >> $MAIN_DISK_USAGE_LOG

# sudo pip install --upgrade Fiona   # SKIPPED: depends on GDAL
# sudo pip install --upgrade Cartopy   # SKIPPED: Could not find library geos_c
# sudo pip install --upgrade Kartograph    # SKIPPED: not yet released
