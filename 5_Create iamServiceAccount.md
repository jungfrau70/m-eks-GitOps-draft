Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/environment/final/eks/05_setup-IAM-role-for-ServiceAccount'
cd $WORKDIR

#########################################################################################
# 1. Setup IAM role for ServiceAccount
#########################################################################################

bash 1_check-prereqs.sh 
bash 2_create-iam-oidc-provider.sh 
bash 3_create-iam-policy.sh 