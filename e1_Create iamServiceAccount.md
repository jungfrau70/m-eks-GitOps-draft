Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

References:
-- https://www.eksworkshop.com/020_prerequisites/

export WORKDIR='/home/ec2-user/workshop/alb/1_create-IAMServiceAccount'
cd $WORKDIR

#########################################################################################
# 1. Setup IAM role for ServiceAccount
#########################################################################################

bash 1_check-prereqs.sh 
bash 2_create-iam-oidc-provider.sh 
bash 3_create-iam-policy.sh 
