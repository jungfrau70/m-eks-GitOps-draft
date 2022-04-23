#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add elastic https://helm.elastic.co
helm repo update

helm install $RELEASE elastic/elasticsearch \
	--namespace=$NAMESPACE \
	-f values.yaml
    