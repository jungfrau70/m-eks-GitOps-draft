#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install $RELEASE bitnami/kibana \
	--namespace=$NAMESPACE \
	-f values.yaml
	
	
helm upgrade --namespace efk kibana bitnami/kibana \
    --set elasticsearch.hosts[0]=elasticsearch-master-headless.efk.svc \
    --set elasticsearch.port=9200 \
    -f values.yaml