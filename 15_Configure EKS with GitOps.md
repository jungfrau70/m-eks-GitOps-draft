Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR

#########################################################################################
# 1. Create namespaces, dev/staging/production
#########################################################################################

# in case of gitops
cp config/ns-dev.yml /home/ec2-user/environment/airflow-eks-config/namespaces/
cp config/ns-staging.yml /home/ec2-user/environment/airflow-eks-config/namespaces/
cp config/ns-production.yml /home/ec2-user/environment/airflow-eks-config/namespaces/

cd /home/ec2-user/environment/airflow-eks-config/
git add .
git commit -m "create ns - dev/staging/production"
git push

# Perform sync manually
fluxctl sync --k8s-fwd-ns flux

# Useful kubectl commands
kubectl -n flux get po
kubectl get ns
kubectl -n flux logs [pod-name]
kubectl apply -f config/ns-dev.yml


******************************
# Set git to use the credential memory cache
git config --global credential.helper cache

# Set the cache to timeout after one hour (setting is in seconds)
git config --global credential.helper 'cache --timeout=3600'

# github token: 
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


#git clone https://github.com/jungfrau70/4team-eks.git eks
#git clone https://github.com/jungfrau70/data-engineering.git
#git clone https://github.com/marclamberti/airflow-materials-aws.git airflow