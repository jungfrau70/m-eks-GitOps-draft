#!/bin/bash

source .env

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/${DASHBOARD_VERSION}/aio/deploy/recommended.yaml

kubectl proxy --port=8080 --address=0.0.0.0 --disable-filter=true &
