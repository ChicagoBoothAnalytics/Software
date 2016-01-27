#!/bin/bash


PORT=8133
MONITORING_PORT=4040


# parse command-line options
while getopts "d:" opt
do
    case $opt in
        d)
            AWS_EMR_CLUSTER_PUBLIC_DNS=$OPTARG
            ;;
    esac
done


echo "Opening LOCALHOST:$PORT on your web browser..."
python -m webbrowser http://localhost:$PORT

echo "Please enter 'yes' if asked 'Are you sure you want to continue connecting (yes/no)?' below; then please wait a few seconds."
# connect to AWS EMR Cluster's Jupyter Notebook environment via a pipe
ssh -o ServerAliveInterval=10 -i keypair.pem -N -L $PORT:$AWS_EMR_CLUSTER_PUBLIC_DNS:$PORT hadoop@$AWS_EMR_CLUSTER_PUBLIC_DNS

# to monitor Spark cluster:
# ssh -o ServerAliveInterval=10 -i keypair.pem -N -L 4040:<Cluster Master Public DNS>:4040 hadoop@<Cluster Master Public DNS>
