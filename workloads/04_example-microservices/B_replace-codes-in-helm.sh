#!/bin/bash

cd  /home/ec2-user/environment/final/eks/04_example-microservices
#create subfolders for each template type
mkdir -p ./eksdemo/templates/deployment
mkdir -p ./eksdemo/templates/service

# Copy and rename frontend manifests
cp ./ecsdemo-frontend/kubernetes/deployment.yaml ./eksdemo/templates/deployment/frontend.yaml
cp ./ecsdemo-frontend/kubernetes/service.yaml ./eksdemo/templates/service/frontend.yaml

# Copy and rename crystal manifests
cp ./ecsdemo-crystal/kubernetes/deployment.yaml ./eksdemo/templates/deployment/crystal.yaml
cp ./ecsdemo-crystal/kubernetes/service.yaml ./eksdemo/templates/service/crystal.yaml

# Copy and rename nodejs manifests
cp ./ecsdemo-nodejs/kubernetes/deployment.yaml ./eksdemo/templates/deployment/nodejs.yaml
cp ./ecsdemo-nodejs/kubernetes/service.yaml ./eksdemo/templates/service/nodejs.yaml


