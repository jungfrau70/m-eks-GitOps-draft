#!/bin/bash

source .env

eksctl utils associate-iam-oidc-provider \
    --region $AWS_REGION \
    --cluster $AWS_CLUSTER_NAME \
    --approve

