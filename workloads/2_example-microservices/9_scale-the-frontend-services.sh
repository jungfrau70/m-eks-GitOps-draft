#!/bin/bash

kubectl get deployments

kubectl scale deployment ecsdemo-frontend --replicas=3

kubectl get deployments
