#!/bin/bash


# parse command-line options
while getopts "m:p:n:t:q:r:" opt
do
    case $opt in
        m)
            MASTER_INSTANCE_TYPE=$OPTARG
            ;;
        p)
            MASTER_INSTANCE_PRICE=$OPTARG
            ;;
        n)
            NB_WORKER_NODES=$OPTARG
            ;;
        t)
            WORKER_INSTANCE_TYPE=$OPTARG
            ;;
        q)
            WORKER_INSTANCE_PRICE=$OPTARG
            ;;
        r)
            REMARKS=$OPTARG
            ;;
    esac
done


# CONSTANTS
AWS_REGION=us-west-1


echo "Bidding for bare AWS EMR cluster with 1 x $MASTER_INSTANCE_TYPE Master @ \$$MASTER_INSTANCE_PRICE/node/hr + $NB_WORKER_NODES x $WORKER_INSTANCE_TYPE Core Workers @ \$$WORKER_INSTANCE_PRICE/node/hr..."

aws emr create-cluster \
    --name \
        "$REMARKS (bare): 1 x $MASTER_INSTANCE_TYPE Master @ \$$MASTER_INSTANCE_PRICE/node/hr + $NB_WORKER_NODES x $WORKER_INSTANCE_TYPE Core Workers @ \$$WORKER_INSTANCE_PRICE/node/hr" \
    --release-label \
        emr-4.7.2 \
    --instance-groups \
        InstanceGroupType=MASTER,InstanceCount=1,InstanceType=$MASTER_INSTANCE_TYPE,BidPrice=$MASTER_INSTANCE_PRICE \
        InstanceGroupType=CORE,InstanceCount=$NB_WORKER_NODES,InstanceType=$WORKER_INSTANCE_TYPE,BidPrice=$WORKER_INSTANCE_PRICE \
    --no-auto-terminate \
    --use-default-roles \
    --ec2-attributes \
        KeyName=keypair \
    --no-termination-protected \
    --visible-to-all-users \
    --applications \
        Name=Spark

echo "For your cluster's status, please check: $AWS_REGION.console.aws.amazon.com/elasticmapreduce"
