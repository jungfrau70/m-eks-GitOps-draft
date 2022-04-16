#!/bin/bash

# Create
aws kms create-alias --alias-name alias/eks-cluster --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)
#aws kms create-alias --alias-name alias/eks-admin4 --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)
#aws kms delete-alias --alias-name alias/eks

# Export ENV
export MASTER_ARN=$(aws kms describe-key --key-id alias/eks-cluster --query KeyMetadata.Arn --output text)
#export MASTER_ARN=$(aws kms describe-key --key-id alias/eks-admin4 --query KeyMetadata.Arn --output text)
echo "export MASTER_ARN=${MASTER_ARN}" | tee -a ~/.bash_profile
