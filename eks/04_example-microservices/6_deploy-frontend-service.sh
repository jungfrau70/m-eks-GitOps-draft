#!/bin/bash

cd ./ecsdemo-frontend
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
cd -

kubectl get deployment ecsdemo-frontend

