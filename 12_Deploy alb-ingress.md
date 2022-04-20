Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/workshop/ingresses/'
cd $WORKDIR


#########################################################################################
# 1. Deploy RBACS roles and role binding required by the AWS Ingress controller
#########################################################################################

kubectl apply -f iam/airflow-rbac-role-alb-ingress


#########################################################################################
# 2. Create an IAM policy ALBIngressControllerIAMPolicy 
#    to to alllow ALB makes API calls on your behalf
#########################################################################################

source .env
aws iam create-policy \
    --policy-name $POLICY \
    --policy-document file://~/workshop/ingresses/iam/iam-alb-policy.json


#########################################################################################
# 3. Create a service account and an IAM role 
#    for the pod running AWS ALB Ingress controller
#########################################################################################

PolicyARN=`aws iam list-policies --query "Policies[?PolicyName=='ALBIngressControllerIAMPolicy'].Arn" --output text`

eksctl utils associate-iam-oidc-provider \
        --region=ap-northeast-2 \
        --cluster=production \
        --approve

eksctl create iamserviceaccount \
       --cluster=$CLUSTER \
       --namespace=kube-system \
       --name=alb-ingress-controller \
       --attach-policy-arn=$PolicyARN \
       --override-existing-serviceaccounts \
       --approve

# Check
kubectl get sa -A | grep -i ingress
kube-system       alb-ingress-controller               1         34m

#########################################################################################
# 3. Deploy the AWS ALB Ingress controller
#########################################################################################

kubectl apply -f deployments/airflow-alb-ingress-controller.yml


#########################################################################################
# 3. Delete LoadBalancers
#########################################################################################

kubectl get svc -A

kubectl delete svc airflow-dev-webserver -n airflow-dev

kubectl delete svc airflow-stg-webserver -n airflow-stg

kubectl get svc -A


#########################################################################################
# 4. Deploy service with NodePort
#########################################################################################

kubectl apply -f services/airflow-nodeport-dev.yml

kubectl apply -f services/airflow-nodeport-stg.yml

kubectl get svc -A


#########################################################################################
# 5. Deploy ALB Ingresses
#########################################################################################

kubectl get ing -A

kubectl apply -f ingresses/airflow-ingress-dev.yml

kubectl apply -f ingresses/airflow-ingress-stg.yml

kubectl get ing -A


#########################################################################################
# 5. Redeploy Pods with custom uri
#########################################################################################
