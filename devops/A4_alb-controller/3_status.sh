#!/bin/bash

helm status aws-load-balancer-controller -n kube-system
kubectl -n kube-system get po
