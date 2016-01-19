#!/bin/bash

# this script requires an existing installation of Anaconda Python


# some supporting packages
conda install Geos
conda update geos

conda install LibGDAL
conda update libgdal

conda install Proj4
conda update proj4
conda install Proj.4
conda update proj.4

conda install PyProj
conda update pyproj


# Basemap
conda install Basemap
conda update basemap


# other packages
pip install --upgrade Descartes
conda install Fiona
pip install --upgrade Google-API-Python-Client
pip install --upgrade GoogleMaps
conda install PySAL
conda update pysal

# pip install --upgrade Cartopy   SKIP: cannot detect Proj4.8, Geos
# pip install --upgrade Kartograph    SKIP: not yet released
