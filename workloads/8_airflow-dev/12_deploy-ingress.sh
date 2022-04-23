#!/bin/bash

source .env

kubectl apply -f ingress-airflow-alb.yaml
# kubectl apply -f test1-ingress-airflow-alb.yaml