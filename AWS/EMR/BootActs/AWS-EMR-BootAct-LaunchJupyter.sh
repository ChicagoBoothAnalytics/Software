#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# launch Jupyter on Master node only
if grep isMaster /mnt/var/lib/info/instance.json | grep true;
then
    # change Home directory
    export HOME=/mnt/home

    # source script specifying environment variables
    source ~/.EnvVars

    # change to apps directory
    cd $APPS_DIR


    # install R kernel
    wget $GITHUB_REPO_RAW_PATH/BootActs/AWS-EMR-BootAct-InstallJupyterRKernel.R
    dos2unix AWS-EMR-BootAct-InstallJupyterRKernel.R
    Rscript AWS-EMR-BootAct-InstallJupyterRKernel.R
    sudo rm AWS-EMR-BootAct-InstallJupyterRKernel.R
    

    # install Scala kernel
    wget https://oss.sonatype.org/content/repositories/snapshots/com/github/alexarchambault/jupyter/jupyter-scala-cli_2.11.6/0.2.0-SNAPSHOT/jupyter-scala_2.11.6-0.2.0-SNAPSHOT.zip
    unzip jupyter-scala_*.zip
    sudo rm jupyter-scala_*.zip
    cd jupyter-scala_*/bin
    chmod 777 jupyter-scala
    ./jupyter-scala


    # launch Jupyter as "no hang-up" background process
    cd ~
    nohup /usr/local/bin/ipython notebook --no-browser &
fi
