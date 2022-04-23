#!/bin/bash

cd ./ecsdemo-frontend
cat kubernetes/service.yaml
# kubectl apply -f kubernetes/deployment.yaml
# kubectl apply -f kubernetes/service.yaml
cd -

kubectl get svc
