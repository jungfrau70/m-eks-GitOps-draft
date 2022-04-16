Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/environment/final/eks/07_EFK'
cd $WORKDIR


#########################################################################################
# 1. Deploy EFK
#########################################################################################

cd elasticsearch/
cat .env
bash 1_deploy.sh 
cd -

cd fluentd/
cat .env
bash 1_deploy.sh 
cd -

cd kibana/
cat .env
bash 1_deploy.sh
cd -

#########################################################################################
# 2. Check EFK
#########################################################################################

bash 0_monitor.sh 