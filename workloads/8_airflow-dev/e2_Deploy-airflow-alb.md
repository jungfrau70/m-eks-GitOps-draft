Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster


#########################################################################################
# 1. Deploy airflow with LoadBalancer (L4)
#########################################################################################

export WORKDIR='/home/ec2-user/workshop/workloads/8_airflow-dev'
cd $WORKDIR

cat .env

cat 11_deploy.sh 

# deploy
bash 11_deploy.sh

#########################################################################################
# 2. Change the service type
#########################################################################################

# get svc
kubectl -n airflow-dev get svc

# change service type (LoadBalancer to NodePort)
kubectl -n airflow-dev patch svc airflow-dev-webserver -p '{"spec": {"type": "NodePort"}}'
kubectl -n airflow-dev patch svc airflow-dev-webserver -p '{"spec": {"type": "LoadBalancer"}}'

# Delete
# kubectl -n airflow-dev delete svc airflow-dev-webserver
# kubectl -n airflow-stg delete svc airflow-stg-webserver

#########################################################################################
# 3. Change the service type
#########################################################################################

bash 12_deploy-ingress.sh

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


export EKS_CLUSTER_VERSION=$(aws eks describe-cluster --name production --query cluster.version --output text)

if [ "`echo "${EKS_CLUSTER_VERSION} < 1.19" | bc`" -eq 1 ]; then     
    curl -s https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.3.1/docs/examples/2048/2048_full.yaml \
    | sed 's=alb.ingress.kubernetes.io/target-type: ip=alb.ingress.kubernetes.io/target-type: instance=g' \
    | kubectl apply -f -
fi

if [ "`echo "${EKS_CLUSTER_VERSION} >= 1.19" | bc`" -eq 1 ]; then     
    curl -s https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.3.1/docs/examples/2048/2048_full_latest.yaml \
    | sed 's=alb.ingress.kubernetes.io/target-type: ip=alb.ingress.kubernetes.io/target-type: instance=g' \
    | kubectl apply -f -
fi

