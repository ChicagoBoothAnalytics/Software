#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# launch Jupyter on Master node only
if grep isMaster /mnt/var/lib/info/instance.json | grep true;
then
    # change Home directory
    export HOME=/mnt/home
    cd ~

    # launch Jupyter as "no hang-up" background process
    nohup /usr/local/bin/ipython notebook --no-browser &
fi
