#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add apache-airflow https://airflow.apache.org/
helm repo update

#helm install $RELEASE bitnami/airflow \
#	--namespace=$NAMESPACE --debug
    
helm install $RELEASE apache-airflow/airflow \
 	--namespace=$NAMESPACE \
 	-f values.yaml
