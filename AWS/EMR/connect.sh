#!/bin/bash


PORT=8133
MONITORING_PORT=4040


# open Jupyter notebook on web browser
python -m webbrowser http://localhost:$PORT


# parse command-line options
while getopts "d:" opt
do
    case $opt in
        d)
            AWS_EMR_CLUSTER_PUBLIC_DNS=$OPTARG
            ;;
    esac
done


# connect to AWS EMR Cluster's iPython Notebook via a pipe
echo "Please open LOCALHOST:$PORT on your web browser"
ssh -o ServerAliveInterval=10 -i keypair.pem -N -L $PORT:$AWS_EMR_CLUSTER_PUBLIC_DNS:$PORT hadoop@$AWS_EMR_CLUSTER_PUBLIC_DNS


# to monitor Spark cluster:
# ssh -o ServerAliveInterval=10 -i keypair.pem -N -L 4040:<Cluster Master DNS>:4040 hadoop@<Cluster Master DNS>
