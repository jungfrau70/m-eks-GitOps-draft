Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR

#########################################################################################
# 1. (eksAdmin) Install 
#########################################################################################

bash alb-controller/1_install.sh


#########################################################################################
# 2. (eksAdmin) Deploy
#########################################################################################

bash alb-controller/2_deploy.sh


# Trouble shooting
cd aws-load-balancer-controller/
eksctl get cluster production
helm install aws-load-balancer-controller .             --set clusterName=$CLUSTER             --set serviceAccount.create=false             --set serviceAccount.name=aws-load-balancer-controller \
kubectl -n production describe po airflow-production-create-user-5fr42 
kubectl get deploy -n production
kubectl -n production describe deploy aws-load-balancer-controller
helm delete aws-load-balancer-controller -n production
helm ls -A
