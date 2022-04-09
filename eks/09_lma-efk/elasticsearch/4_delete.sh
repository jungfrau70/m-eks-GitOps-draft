#!/bin/bash
source ./.env

helm delete $RELEASE --namespace=$NAMESPACE
