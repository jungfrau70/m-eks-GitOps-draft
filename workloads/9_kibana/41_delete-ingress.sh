#!/bin/bash

source .env

kubectl delete -f ingress-kibana.yaml
