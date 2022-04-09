Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR

#########################################################################################
# 1. (eksAdmin) Create eks cluster
#########################################################################################

# Get eks' Key Arn
echo $MASTER_ARN

# Check if kms-alias key arn is correct.
tail -n 5 config/eks-production.yaml

# It is required to use only this role after the cluster creation
# If not, it makes the authoriztion error

# Create the cluster
eksctl create cluster -f config/eks-production.yaml 

# Check if the cluster is healthy, After creation. It takes about 15 minutes
kubectl get nodes
kubectl get pods --all-namespaces
