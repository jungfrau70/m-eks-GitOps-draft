#!/bin/bash

source .env

kubectl apply -f ingress-ingress-airflow-alb.yaml
