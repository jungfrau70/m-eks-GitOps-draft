#!/bin/bash

kubectl apply -k github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master

kubectl get crd

