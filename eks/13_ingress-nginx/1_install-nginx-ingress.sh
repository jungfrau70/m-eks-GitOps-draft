#!/bin/bash

#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add stable https://charts.helm.sh/stable
helm repo update

helm install $RELEASE stable/nginx-ingress \
       --namespace=$NAMESPACE \
       --set controller.hostNetwork=true,controller.kind=DaemonSet \
       --set controller.config.proxy-body-size=256m

#kubectl patch svc $RELEASE-controller -n $NAMESPACE -p '{"spec": {"type": "LoadBalancer"}}'
