#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install $RELEASE bitnami/elasticsearch \
	--namespace=$NAMESPACE \
--set client.replicas=1 \
--set master.replicas=1 \
--set cluster.env.MINIMUM_MASTER_NODES=1 \
--set cluster.env.RECOVER_AFTER_MASTER_NODES=1 \
--set cluster.env.EXPECTED_MASTER_NODES=1 \
--set data.replicas=1 \
--set data.heapSize=300m \
--set master.persistence.enabled=false \
--set data.persistence.enabled=false
