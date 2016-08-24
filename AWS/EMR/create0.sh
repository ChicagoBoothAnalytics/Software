#!/usr/bin/env bash


# parse command-line options
while getopts "m:p:n:t:q:a:r:k:z:" opt
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
        a)
            AWS_PROFILE=$OPTARG
            ;;
        r)
            AWS_REGION=$OPTARG
            ;;
        k)
            AWS_KEY_PAIR=$OPTARG
            ;;
        z)
            REMARKS=$OPTARG
            ;;
    esac
done


echo "Bidding for bare AWS EMR cluster with 1 x $MASTER_INSTANCE_TYPE Master @ \$$MASTER_INSTANCE_PRICE/node/hr + $NB_WORKER_NODES x $WORKER_INSTANCE_TYPE Core Workers @ \$$WORKER_INSTANCE_PRICE/node/hr..."

aws emr create-cluster \
    --name \
        "$REMARKS (bare): 1 x $MASTER_INSTANCE_TYPE Master @ \$$MASTER_INSTANCE_PRICE/node/hr + $NB_WORKER_NODES x $WORKER_INSTANCE_TYPE Core Workers @ \$$WORKER_INSTANCE_PRICE/node/hr" \
    --release-label \
        emr-5.0.0 \
    --instance-groups \
        InstanceGroupType=MASTER,InstanceCount=1,InstanceType=$MASTER_INSTANCE_TYPE,BidPrice=$MASTER_INSTANCE_PRICE \
        InstanceGroupType=CORE,InstanceCount=$NB_WORKER_NODES,InstanceType=$WORKER_INSTANCE_TYPE,BidPrice=$WORKER_INSTANCE_PRICE \
    --no-auto-terminate \
    --use-default-roles \
    --ec2-attributes \
        KeyName=$AWS_KEY_PAIR \
    --no-termination-protected \
    --visible-to-all-users \
    --applications \
        Name=Spark \
    --profile \
        $AWS_PROFILE

echo "For your cluster's status, please check: $AWS_REGION.console.aws.amazon.com/elasticmapreduce"
