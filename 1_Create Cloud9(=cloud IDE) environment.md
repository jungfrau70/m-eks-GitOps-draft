Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR

#########################################################################################
# 1. Install CLI files
#########################################################################################

bash config/install-CLIs.sh


#########################################################################################
# 2. Install Anaconda
#########################################################################################

bash config/install-conda.sh

## Exit current terminal
^D

## Open new terminal

#########################################################################################
# 3. Create Virtual Environment
#########################################################################################

## Create virtual env - eksAdmin

conda env create -f environment.yml

conda env list
# conda environments:
#
eksAdmin                 /home/ec2-user/.conda/envs/eksAdmin
base                  *  /opt/conda

#conda remove --name eksAdmin --all

conda activate eksAdmin


pip --version

# Upgrade pip
pip install --upgrade pip


#########################################################################################
# 4. (eksAdmin) Install awscli
#########################################################################################

# upgrade aws cli
pip install --upgrade awscli && hash -r


#########################################################################################
# 5. (AWS console) Create/Configure IAM role
#########################################################################################

# Create role - eksAdminRole with AdministratorAccess

# Attach the role, eksAdminRole to EC2(for Cloud9)


#########################################################################################
# 6. (eksAdmin) Configure AWS ENV variables
#########################################################################################

bash config/setup-aws-env-variables.sh


#########################################################################################
# 7. (eksAdmin) Create ssh-key and apply it into EC2(=Cloud9)
#########################################################################################

bash config/create-ssh-key-n-push-import-key-pair-in-aws-cloud.sh


#########################################################################################
# 8. (eksAdmin) Create kms-alias of above eks key-pair
#########################################################################################

bash config/create-kms-alias.sh


#########################################################################################
# 9. (eksAdmin) Install aws-iam-authenticator
#########################################################################################

bash config/install-aws-iam-authenticator.sh
