#!/bin/sh

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

# connect to AWS EMR Cluster's iPython Notebook via a pipe
echo "Please open LOCALHOST:$PORT on your web browser"
ssh -o ServerAliveInterval=10 -i keypair.pem -N -L $PORT:$AWS_EMR_CLUSTER_PUBLIC_DNS:$PORT hadoop@$AWS_EMR_CLUSTER_PUBLIC_DNS

# ssh -o ServerAliveInterval=10 -i keypair.pem -N -L 4040:ec2-52-53-239-92.us-west-1.compute.amazonaws.com:4040 hadoop@ec2-52-53-239-92.us-west-1.compute.amazonaws.com

# ssh -o ServerAliveInterval=10 -i keypair.pem -N -L 5006:ec2-52-53-210-250.us-west-1.compute.amazonaws.com:5006 hadoop@ec2-52-53-210-250.us-west-1.compute.amazonaws.com

