#!/bin/bash

# Create
aws kms create-alias --alias-name alias/eks --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)
#kms delete-alias --alias-name alias/eks

# Export ENV
export MASTER_ARN=$(aws kms describe-key --key-id alias/eks --query KeyMetadata.Arn --output text)
echo "export MASTER_ARN=${MASTER_ARN}" | tee -a ~/.bash_profile
