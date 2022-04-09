#!/bin/bash

watch -n 1 kubectl get ing,svc -n $1
