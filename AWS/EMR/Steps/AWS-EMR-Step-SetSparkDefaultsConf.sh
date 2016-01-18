#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# change Home directory
export HOME=/mnt/home


# source script specifying environment variables
source ~/.EnvVars


# modify default Spark Defaults Config (spark-defaults.conf) file
cd $SPARK_HOME/conf
sudo mv $SPARK_DEFAULTS_CONF_FILE_NAME ARCHIVED-$SPARK_DEFAULTS_CONF_FILE_NAME
sudo wget $GITHUB_REPO_RAW_PATH/.config/$SPARK_DEFAULTS_CONF_FILE_NAME
sudo dos2unix $SPARK_DEFAULTS_CONF_FILE_NAME
