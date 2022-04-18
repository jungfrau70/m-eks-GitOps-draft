#!/bin/bash

source .env

kubectl apply -f ingress-airflow-alb.yaml
