Prerequistes:
- Create Cloud9 for EKS environment

References:
- 

export WORKDIR='/home/ec2-user/workshop/eks'
cd $WORKDIR

#########################################################################################
# 1. add a new label disktype=ssd to the first node on this list.
#########################################################################################

# list nodes
kubectl get nodes

# list nodes with selector
kubectl get nodes --selector disktype=ssd

# export the first node name as a variable
kubectl get nodes -o json | jq -r '.items[0].metadata.name'

kubectl get nodes -o json | jq -r '.items[0].metadata.name' > out

export FIRST_NODE_NAME=$(kubectl get nodes -o json | jq -r '.items[0].metadata.name')

# add the label to the node
kubectl label nodes ${FIRST_NODE_NAME} disktype=ssd

# list nodes with selector
kubectl get nodes --selector disktype=ssd



#########################################################################################
# 2. Deploy a nginx pod only to the node with the new label
#########################################################################################

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  nodeSelector:
    disktype: ssd
EOF

#########################################################################################
# 3. Check where the nginx pod is deployed
#########################################################################################

kubectl get pod -o wide

#########################################################################################
# 4. Clean up
#########################################################################################

# delete pod
kubectl delete pod nginx

# add the label to the node
kubectl get nodes ${FIRST_NODE_NAME} --show-labels