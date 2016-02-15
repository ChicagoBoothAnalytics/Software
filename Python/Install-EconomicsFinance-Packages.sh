#!/bin/bash

# this script requires an existing installation of Anaconda Python


# install / update supporting packages
conda install Cycler
conda update cycler

conda install Decorator
conda update decorator

conda install Future
conda update future

conda install PyParsing
conda update pyparsing

conda install Python-DateUtil
conda update python-dateutil

conda install PyTZ
conda update pytz

conda install Six
conda update six

pip install --upgrade Tabulate


# install Economics & Finance packages
pip install --upgrade FFn --no-dependencies
