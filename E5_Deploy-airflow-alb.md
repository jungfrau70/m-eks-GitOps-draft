Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/workshop/expose-apps/A5_airflow-alb'
cd $WORKDIR


#########################################################################################
# 1. Delete classic LBs
#########################################################################################

# for airflow-dev
kubectl -n airflow-dev delete svc airflow-dev-webserver

# for airflow-stg
kubectl -n airflow-stg delete svc airflow-stg-webserver

#########################################################################################
# 2. Check if alb pods run
#########################################################################################

bash 0_monitor.sh 

NAMESPACE     NAME                                            READY   STATUS    RESTARTS   AGE
kube-system   aws-load-balancer-controller-85cfbbd877-2cmvq   1/1     Running   0          6m49s
kube-system   aws-load-balancer-controller-85cfbbd877-6gzrg   1/1     Running   0          6m49s


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
