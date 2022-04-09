#!/bin/bash
source ./.env

helm delete $RELEASE -n $NAMESPACE
