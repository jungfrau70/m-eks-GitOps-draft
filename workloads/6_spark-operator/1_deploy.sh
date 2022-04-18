#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
helm repo update

helm install $RELEASE spark-operator/spark-operator \
	--namespace=$NAMESPACE \
    --set sparkJobNamespace=default
    