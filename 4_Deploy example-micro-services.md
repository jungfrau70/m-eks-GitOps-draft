Prerequistes:
- Create Cloud9 for EKS environment

export WORKDIR='/home/ec2-user/environment/final/eks/04_example-microservices'
cd $WORKDIR


#########################################################################################
# 1. Download source codes
#########################################################################################

git clone https://github.com/aws-containers/ecsdemo-frontend.git
git clone https://github.com/aws-containers/ecsdemo-nodejs.git
git clone https://github.com/aws-containers/ecsdemo-crystal.git


#########################################################################################
# 2. Deploy/Cleanup App/Services
#########################################################################################

1_deploy-sample-app.sh
2_deploy-nodejs-backend-api.sh
3_deploy-crystal-backend-api.sh
4_check-service-types.sh
5_create-service-role.sh
6_deploy-frontend-service.sh
7_find-the-service-address.sh
8_scale-the-backend-services.sh
9_scale-the-frontend-services.sh
A_cleanup-the-applications.sh


#########################################################################################
# 3. Install Helm CLI
#########################################################################################

export WORKDIR='/home/ec2-user/environment/final/'
cd $WORKDIR

bash eks/install-helm.sh


#########################################################################################
# 4. Deploy nginx with Helm
#########################################################################################

# Update Helm’s local list of Charts
helm repo update

# List all Charts:
helm search repo

# Search nginx in Helm Repos
helm search repo nginx

# Add the BITNAMI repo
helm repo add bitnami https://charts.bitnami.com/bitnami

# List all Charts from bitnami repo
helm search repo bitnami

# Search nginx in Helm Repos (again)
helm search repo nginx

# Search the Bitnami repo, just for nginx
helm search repo bitnami/nginx



#########################################################################################
# 5. Install bitnami/nginx
#########################################################################################

kubectl get svc,po,deploy

helm install mywebserver bitnami/nginx

helm ls 

helm status nginx

kubectl get svc,po,deploy

kubectl describe deployment mywebserver

kubectl get pods -l app.kubernetes.io/name=nginx

kubectl get service mywebserver-nginx -o wide



#########################################################################################
# 6. Clean Up
#########################################################################################


helm list

helm uninstall mywebserver

kubectl get pods -l app.kubernetes.io/name=nginx
kubectl get service mywebserver-nginx -o wide


#########################################################################################
# 7. Deploy Example Microservices Using Helm
#########################################################################################

export WORKDIR='/home/ec2-user/environment/final/eks/04_example-microservices'
cd $WORKDIR

helm create eksdemo
cd eksdemo

# Delete these boilerplate files
rm -rf ./templates/
rm ./Chart.yaml
rm ./values.yaml

cat <<EOF > ./Chart.yaml
apiVersion: v2
name: eksdemo
description: A Helm chart for EKS Workshop Microservices application
version: 0.1.0
appVersion: 1.0
EOF