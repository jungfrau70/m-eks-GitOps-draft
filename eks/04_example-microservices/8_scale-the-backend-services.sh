#!/bin/bash

kubectl get deployments

kubectl scale deployment ecsdemo-nodejs --replicas=3
kubectl scale deployment ecsdemo-crystal --replicas=3

kubectl get deployments
