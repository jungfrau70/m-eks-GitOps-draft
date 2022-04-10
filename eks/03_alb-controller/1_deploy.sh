#!/bin/bash

source ./.env

#kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add eks https://aws.github.io/eks-charts
helm repo update

kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"

echo 'export LBC_VERSION="v2.0.0"' >>  ~/.bash_profile
.  ~/.bash_profile

if [ ! -x ${LBC_VERSION} ]
  then
    tput setaf 2; echo '${LBC_VERSION} has been set.'
  else
    tput setaf 1;echo '${LBC_VERSION} has NOT been set.'
fi

helm install aws-load-balancer-controller \
    eks/aws-load-balancer-controller \
    -n kube-system \
    --set clusterName=$AWS_CLUSTER_NAME \
    --set serviceAccount.create=false  \
    --set serviceAccount.name=aws-load-balancer-controller

# helm install aws-load-balancer-controller \
#     eks/aws-load-balancer-controller \
#     -n kube-system \
#     --set clusterName=$AWS_CLUSTER_NAME

echo 'export LBC_VERSION="v2.0.0"' >>  ~/.bash_profile
.  ~/.bash_profile

if [ ! -x ${LBC_VERSION} ]
  then
    tput setaf 2; echo '${LBC_VERSION} has been set.'
  else
    tput setaf 1;echo '${LBC_VERSION} has NOT been set.'
fi

# helm upgrade -i aws-load-balancer-controller \
#     ./aws-load-balancer-controller/ \
#     -n kube-system \
#     --set clusterName=production \
#     --set serviceAccount.create=false \
#     --set serviceAccount.name=aws-load-balancer-controller \
#     --set image.tag="${LBC_VERSION}" \
#     --values=./aws-load-balancer-controller/values.yaml

#     # eks/aws-load-balancer-controller \
# kubectl -n kube-system rollout status deployment aws-load-balancer-controller
