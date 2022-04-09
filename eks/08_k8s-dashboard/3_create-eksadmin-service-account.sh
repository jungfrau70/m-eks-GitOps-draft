#!/bin/bash

cat << EOF | kubectl apply -f -
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: eksadmin
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: eksadmin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: eksadmin
  namespace: kube-system
---
EOF
