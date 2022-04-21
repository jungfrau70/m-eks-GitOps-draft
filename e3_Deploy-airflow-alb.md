Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/workshop/workloads/13_ingresses'
cd $WORKDIR


#########################################################################################
# 1. Change the service type
#########################################################################################

# Patch
kubectl -n airflow-dev patch svc airflow-dev-webserver -p '{"spec": {"type": "NodePort"}}'

# Delete
# kubectl -n airflow-dev delete svc airflow-dev-webserver
# kubectl -n airflow-stg delete svc airflow-stg-webserver


#########################################################################################
# *. (If required) Trouble shooting
#########################################################################################

cd aws-load-balancer-controller/
eksctl get cluster production
helm install aws-load-balancer-controller .             --set clusterName=$CLUSTER             --set serviceAccount.create=false             --set serviceAccount.name=aws-load-balancer-controller \
kubectl -n production describe po airflow-production-create-user-5fr42 
kubectl get deploy -n production
kubectl -n production describe deploy aws-load-balancer-controller
helm delete aws-load-balancer-controller -n production
helm ls -A
