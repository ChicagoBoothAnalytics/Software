#!/bin/bash

# this script requires an existing installation of Anaconda Python


# install / update SQLalchemy
conda install SQLalchemy
conda update sqlalchemy


# install commonly-applicable drivers
# pip install --upgrade Egenix-mxODBC   SKIPPED: installation fails on Mac
conda install PyODBC
conda update pyodbc


# install Firebird drivers
pip install --upgrade FDB


# install Microsoft SQL Server drivers
pip install --upgrade PyMSSQL
pip install --upgrade AdoDBAPI


# download / install MySQL drivers
# pip install --upgrade CyMySQL   SKIPPED: requires C++
conda install MySQL-Connector-Python
conda update mysql-connector-python
# pip install --upgrade MySQL-Python   SKIPPED: requires MySQL software
# pip install --upgrade OurSQL   SKIPPED: requires Cython extension
conda install PyMySQL
conda update pymysql


# download / install PostgreSQL drivers
pip install --upgrade PG8000
# pip install --upgrade Py-PostgreSQL   SKIPPED: for Python 3.1 and greater only

conda install PsycoPG2
conda update psycopg2
# for PsycoPG2 on Windows, go here: http://www.lfd.uci.edu/~gohlke/pythonlibs/#psycopg,
# download a .whl file appropriate for your Windows machine's processor (32-bit / 64-bit),
# enter a command-line terminal, navigate to the download folder, and
# run command: pip install <the-downloaded-file-name.whl>

# pip install --upgrade PsycoPG2CFFI   SKIPPED: requires PostgreSQL installed


# install Jupyter SQL "magic"
pip install iPython-SQL
