#!/bin/bash

source .env

kubectl apply -f ingress-kibana.yaml
