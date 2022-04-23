Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR

#########################################################################################
# 1. (eksAdmin) Configure Git account
#########################################################################################

# Config git
git config --global user.name "jungfrau70"
git config --global user.email "inhwan.jung@gmail.com"


#########################################################################################
# 2. (eksAdmin) Create new github repo for gitops in github.com
#########################################################################################

# Create new github
jungfrau70/airflow-eks-config

# Open the SSH and GPG keys menu in the github, add ssh-key inthere
cat ~/.ssh/id_rsa.pub


#########################################################################################
# 3. (eksAdmin) Create local direcotry for gitops files
#########################################################################################

mkdir airflow-eks-config
export WORKDIR='/home/ec2-user/environment/airflow-eks-config'
cd $WORKDIR


#########################################################################################
# 4. (eksAdmin) Initialize git repo
#########################################################################################

git init
git remote add origin https://github.com/jungfrau70/airflow-eks-config.git

git add .
git commit -m "gitops with k8s"
git push origin master


#########################################################################################
# 4. (eksAdmin) Install Flux
#########################################################################################

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR

# create the flux Kubernetes namespace
kubectl create namespace flux

# add the Flux chart repository to Helm and install Flux.
helm repo add fluxcd https://charts.fluxcd.io

# change gitID with yours
export gitID=jungfrau70
helm upgrade -i flux fluxcd/flux \
--set git.url=git@github.com:${gitID}/airflow-eks-config \
--namespace flux

helm upgrade -i helm-operator fluxcd/helm-operator --wait \
--namespace flux \
--set git.ssh.secretName=flux-git-deploy \
--set git.pollInterval=1m \
--set chartsSyncInterval=1m \
--set helm.versions=v3

# Check the install. 3 pods should be running
kubectl get pods -n flux

# Install fluxctl in order to get the SSH key to allow GitHub write access. 
# This allows Flux to keep the configuration in GitHub in sync with the configuration deployed in the cluster.
sudo wget -O /usr/local/bin/fluxctl https://github.com/fluxcd/flux/releases/download/1.19.0/fluxctl_linux_amd64
sudo chmod 755 /usr/local/bin/fluxctl

fluxctl version

# Add Deploy Key for github repo, jungfrau70/airflow-eks-config 
# with ssh-key, the result of the command below
fluxctl identity --k8s-fwd-ns flux

mkdir airflow-eks-config/{workloads,releases,namespaces}
find airflow-eks-config/ -type d -exec touch {}/.keep \;
cd airflow-eks-config
git add .
git commit -am "directory structure"
git push

