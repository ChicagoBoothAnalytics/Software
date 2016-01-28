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


    # install iR kernel
    wget $GITHUB_REPO_RAW_PATH/BootActs/AWS-EMR-BootAct-InstallJupyterIRKernelRelatedPackages.R
    dos2unix AWS-EMR-BootAct-InstallJupyterIRKernelRelatedPackages.R
    sudo Rscript AWS-EMR-BootAct-InstallJupyterIRKernelRelatedPackages.R
    sudo rm AWS-EMR-BootAct-InstallJupyterIRKernelRelatedPackages.R

    wget $GITHUB_REPO_RAW_PATH/BootActs/AWS-EMR-BootAct-InstallJupyterIRKernel.R
    dos2unix AWS-EMR-BootAct-InstallJupyterIRKernel.R
    Rscript AWS-EMR-BootAct-InstallJupyterIRKernel.R
    sudo rm AWS-EMR-BootAct-InstallJupyterIRKernel.R

    echo `df -h / | sed -n 2p` Jupyter iR Kernel >> $MAIN_DISK_USAGE_LOG


    # install iJulia kernel
    wget $GITHUB_REPO_RAW_PATH/BootActs/AWS-EMR-BootAct-InstallJupyterIJuliaKernel.jl
    dos2unix AWS-EMR-BootAct-InstallJupyterIJuliaKernel.jl
    set +e
    julia AWS-EMR-BootAct-InstallJupyterIJuliaKernel.jl
    set -e
    sudo rm AWS-EMR-BootAct-InstallJupyterIJuliaKernel.jl

    echo `df -h / | sed -n 2p` Jupyter iJulia Kernel >> $MAIN_DISK_USAGE_LOG


    # install Scala kernel
    wget https://oss.sonatype.org/content/repositories/snapshots/com/github/alexarchambault/jupyter/jupyter-scala-cli_2.11.6/0.2.0-SNAPSHOT/jupyter-scala_2.11.6-0.2.0-SNAPSHOT.zip
    unzip jupyter-scala_*.zip
    sudo rm jupyter-scala_*.zip
    cd jupyter-scala_*/bin
    chmod 777 jupyter-scala
    ./jupyter-scala
    sudo mv /home/hadoop/.ipython/kernels/scala211/ ~/.local/share/jupyter/kernels/

    echo `df -h / | sed -n 2p` Jupyter Scala Kernel >> $MAIN_DISK_USAGE_LOG


    # install SQL Jupyter "magic"
    sudo pip install ipython-sql


    # launch Jupyter as "no hang-up" background process
    cd ~
    nohup /usr/local/bin/ipython notebook --no-browser &
fi
