#!/bin/bash

source .env

kubectl apply -f ingress-k8s-dashboard-prod.yaml
