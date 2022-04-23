#!/bin/bash

source .env

kubectl delete -f ingress-airflow-alb.yaml
# kubectl delete -f test1-ingress-airflow-alb.yaml