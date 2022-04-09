Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR

#########################################################################################
# 1. (eksAdmin) Deploy airflow with gitops
#########################################################################################

kubectl create namespace airflow
kubectl get namespaces

helm repo add apache-airflow https://airflow.apache.org
helm repo update
helm search repo airflow
helm install airflow apache-airflow/airflow --namespace airflow --debug