Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

References:
-- https://www.eksworkshop.com/020_prerequisites/

export WORKDIR='/home/ec2-user/environment/workshop/alb-controller'
cd $WORKDIR

#########################################################################################
# 1. Setup IAM role for ServiceAccount
#########################################################################################

bash iam/1_check-prereqs.sh 
bash iam/2_create-iam-oidc-provider.sh 
bash iam/3_create-iam-policy.sh 
bash iam/4_create-targetgroupbinding-crds.sh
