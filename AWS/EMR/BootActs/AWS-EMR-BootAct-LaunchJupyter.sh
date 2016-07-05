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

    # install ZeroMQ
    git clone https://github.com/zeromq/libzmq
    cd libzmq
    # wget https://github.com/zeromq/zeromq4-1/releases/download/v4.1.5/zeromq-4.1.5.tar.gz
    # tar xzf zeromq-*.tar.gz
    # sudo rm zeromq-*.tar.gz
    # cd zeromq-*
    ./autogen.sh
    ./configure --prefix=$ZMQ_DIR
    make
    sudo make install
    sudo ldconfig
    cd ..
    sudo rm -r libzmq
    # sudo rm -r zeromq-*
    echo `df -h / | sed -n 2p` ZeroMQ >> $MAIN_DISK_USAGE_LOG

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
    julia AWS-EMR-BootAct-InstallJupyterIJuliaKernel.jl
    sudo rm AWS-EMR-BootAct-InstallJupyterIJuliaKernel.jl

    echo `df -h / | sed -n 2p` Jupyter iJulia Kernel >> $MAIN_DISK_USAGE_LOG


    # install Scala kernel
    curl -L -o jupyter-scala https://git.io/vrHhi
    chmod +x jupyter-scala
    ./jupyter-scala
    sudo rm jupyter-scala
    sudo mv /home/hadoop/.local/share/jupyter/kernels/scala211/ ~/.local/share/jupyter/kernels/

    echo `df -h / | sed -n 2p` Jupyter Scala Kernel >> $MAIN_DISK_USAGE_LOG


    # install SQL Jupyter "magic"
    sudo pip install iPython-SQL


    # launch Jupyter as "no hang-up" background process
    cd ~
    nohup /usr/local/bin/ipython notebook --no-browser &
fi
