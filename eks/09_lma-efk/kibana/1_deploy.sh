#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install $RELEASE bitnami/kibana \
	--namespace=$NAMESPACE \
	--set elasticsearch.hosts[0]=$ES_HOST \
	--set elasticsearch.port=$ES_PORT
