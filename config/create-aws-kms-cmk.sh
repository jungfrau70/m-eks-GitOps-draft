#!/bin/bash

# Create a CMK for the EKS cluster to use when encrypting your Kubernetes secrets:
aws kms create-alias --alias-name alias/eks-production --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)

# Let’s retrieve the ARN of the CMK to input into the create cluster command.
export MASTER_ARN=$(aws kms describe-key --key-id alias/eks-production --query KeyMetadata.Arn --output text)

# let’s save the MASTER_ARN environment variable into the bash_profile
echo "export MASTER_ARN=${MASTER_ARN}" | tee -a ~/.bash_profile
