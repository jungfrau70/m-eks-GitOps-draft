#!/bin/bash

kubectl get service ecsdemo-frontend

kubectl get service ecsdemo-frontend -o wide

ELB=$(kubectl get service ecsdemo-frontend -o json | jq -r '.status.loadBalancer.ingress[].hostname')

curl -m3 -v $ELB


