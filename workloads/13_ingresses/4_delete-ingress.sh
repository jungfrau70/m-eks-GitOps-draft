#!/bin/bash

source .env

kubectl delete -f airflow-ingress-dev.yml
