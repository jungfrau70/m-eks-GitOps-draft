#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install $RELEASE bitnami/kafka \
	--namespace=$NAMESPACE \
--set replicaCount=3 \
--set zookeeper.replicaCount=3