#!/bin/bash
source ./.env

helm status $RELEASE --namespace=$NAMESPACE
