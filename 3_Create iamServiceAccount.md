Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR

#########################################################################################
# 1. (eksAdmin) Setup IAM role for ServiceAccount
#########################################################################################

cd eks/03_setup-IAM-role-for-ServiceAccount/

bash 1_check-prereqs.sh 
bash 2_create-iam-oidc-provider.sh 
bash 3_create-iam-policy.sh 
