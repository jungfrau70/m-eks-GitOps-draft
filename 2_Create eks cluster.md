Prerequistes:
- Create Cloud9 for EKS environment

export WORKDIR='/home/ec2-user/environment/final'
cd $WORKDIR

#########################################################################################
# 1. Validate if it kms cmk
#########################################################################################

# Get kms cmk Arn
echo $MASTER_ARN

# Check if kms-alias key arn is correct.
tail -n 5 config/eks-production.yaml

# It is required to use only this role after the cluster creation
# If not, it makes the authoriztion error


#########################################################################################
# 2. Create eks cluster
#########################################################################################

# Create the cluster
eksctl create cluster -f config/eks-production.yaml 


#########################################################################################
# 3. Check if the cluster works
#########################################################################################

# Check if the cluster is healthy, After creation. It takes about 15 minutes
kubectl get nodes
kubectl get pods --all-namespaces


#########################################################################################
# 4. Export the Worker Role Name for use throughout the workshop
#########################################################################################

STACK_NAME=$(eksctl get nodegroup --cluster eksworkshop-eksctl -o json | jq -r '.[].StackName')
ROLE_NAME=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME | jq -r '.StackResources[] | select(.ResourceType=="AWS::IAM::Role") | .PhysicalResourceId')
echo "export ROLE_NAME=${ROLE_NAME}" | tee -a ~/.bash_profile
