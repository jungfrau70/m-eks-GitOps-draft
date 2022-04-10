#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install $RELEASE bitnami/fluentd \
	--namespace=$NAMESPACE \
       	--set backend.type=es \
	--set backend.es.host=lma-elasticsearch-elasticsearch-coordinating-only.lma.svc.cluster.local
