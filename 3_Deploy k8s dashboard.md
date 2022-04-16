Prerequistes:
- Create Cloud9 for EKS environment

export WORKDIR='/home/ec2-user/environment/final/eks/03_k8s-dashboard'
cd $WORKDIR

#########################################################################################
# 1. Deploy the dashboard
#########################################################################################

bash 1_deploy-k8s-dashboard.sh


#########################################################################################
# 1. Access the dashboard
#########################################################################################

1. In your Cloud9 environment, click Tools / Preview / Preview Running Application
2. Scroll to the end of the URL and append:

/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

3. Open a New Terminal Tab and enter
aws eks get-token --cluster-name production| jq -r '.status.token'


#########################################################################################
# 1. CleanUp
#########################################################################################

bash 4_cleanup-k8s-dashboard.sh