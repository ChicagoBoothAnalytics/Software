#!/bin/bash

# this script requires an existing installation of Anaconda Python


# install / update SQLalchemy
conda install SQLalchemy
conda update sqlalchemy


# install commonly-applicable drivers
pip install --upgrade Egenix-mxODBC
conda install PyODBC
conda update pyodbc


# install Firebird drivers
pip install --upgrade FDB


# install Microsoft SQL Server drivers
pip install --upgrade PyMSSQL
pip install --upgrade AdoDBAPI


# download / install MySQL drivers
# pip install --upgrade CyMySQL   SKIP: requires C++
conda install MySQL-Connector-Python
conda update mysql-connector-python
conda install MySQL-Python
conda update MySQL-Python
# pip install --upgrade OurSQL   SKIP: requires Cython extension
conda install PyMySQL
conda update pymysql


# download / install PostgreSQL drivers
pip install --upgrade PG8000
# pip install --upgrade Py-PostgreSQL   SKIP: for Python 3.1 and greater only
conda install psycopg2   # for Windows, install from .whl here: http://www.lfd.uci.edu/~gohlke/pythonlibs/#psycopg
conda update psycopg2
# pip install --upgrade psycopg2cffi   SKIP: requires PostgreSQL installed
