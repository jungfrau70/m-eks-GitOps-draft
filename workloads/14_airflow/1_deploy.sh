#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

#helm repo add apache-airflow https://airflow.apache.org
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

#helm install $RELEASE bitnami/airflow \
#	--namespace=$NAMESPACE --debug
    
helm install $RELEASE bitnami/airflow \
	--namespace=$NAMESPACE \
	-f values.yaml
	
export AIRFLOW_HOST=$(kubectl get svc --namespace airflow airflow --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
export AIRFLOW_PORT=80

export AIRFLOW_PASSWORD=$(kubectl get secret --namespace "airflow" airflow -o jsonpath="{.data.airflow-password}" | base64 --decode)
export AIRFLOW_FERNET_KEY=$(kubectl get secret --namespace "airflow" airflow -o jsonpath="{.data.airflow-fernet-key}" | base64 --decode)
export AIRFLOW_SECRET_KEY=$(kubectl get secret --namespace "airflow" airflow -o jsonpath="{.data.airflow-secret-key}" | base64 --decode)

helm upgrade --namespace airflow airflow bitnami/airflow \
  --set service.type=LoadBalancer \
  --set web.baseUrl=http://$AIRFLOW_HOST:$AIRFLOW_PORT \
  --set auth.password=$AIRFLOW_PASSWORD \
  --set auth.fernetKey=$AIRFLOW_FERNETKEY \
  --set auth.secretKey=$AIRFLOW_SECRETKEY \
  -f values.yaml