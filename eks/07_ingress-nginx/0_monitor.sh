#!/bin/bash

source ./.env

watch -n 1 kubectl -n $NAMESPACE get ing,svc,ep
