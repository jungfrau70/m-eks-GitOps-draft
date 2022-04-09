#!/bin/bash

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eksadmin | awk '{print $1}')
