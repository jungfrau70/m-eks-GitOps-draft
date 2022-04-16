Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2

References:
- https://www.eksworkshop.com/010_introduction/
- 

export WORKDIR='/home/ec2-user/environment/final'
cd $WORKDIR

#########################################################################################
# 1. Create AWS IAM Account & Role
#########################################################################################

# Create UserGroup
  ㄴ Cloud9users with AdministratorAccess
  
# Create User
  ㄴ admin
  
# Create Role & Attach it to Cloud9
  ㄴ Admin with AdministratorAccess
  
#########################################################################################
# 2. Login to AWS console
#########################################################################################



#########################################################################################
# 3. Create Cloud9 Environment
#########################################################################################

# Create bastion workstation for data engineering
  ㄴ name: bastion
  ㄴ size: t3.medium
  
# Increase disk size
. config/increase-disk-size.sh


#########################################################################################
# 4. Create Cloud9 Environment
#########################################################################################

. config/install-k8s-tools.sh


#########################################################################################
# 5. Update IAM Settings for Cloud9
#########################################################################################

. config/update-IAM-settings.sh


#########################################################################################
# 6. Update IAM Settings for Cloud9
#########################################################################################

. config/update-IAM-settings.sh


#########################################################################################
# 7. Create a CMK for the EKS cluster to use when encrypting your Kubernetes secrets
#########################################################################################

. config/create-aws-kms-cmk.sh


#########################################################################################
# 8. Install eksctl
#########################################################################################

. config/install-eksctl.sh



<!--#########################################################################################-->
<!--# 9. Create key pair for EC2-->
<!--#########################################################################################-->

<!--. config/create-ec2-key-pair.sh-->


<!--#########################################################################################-->
<!--# 10. Update IAM Settings for Cloud9-->
<!--#########################################################################################-->

<!--bash config/create-kms-alias.sh-->




<!--#########################################################################################-->
<!--# 2. Install Anaconda-->
<!--#########################################################################################-->

<!--bash config/install-conda.sh-->

<!--## Exit current terminal-->
<!--^D-->

<!--## Open new terminal-->

<!--#########################################################################################-->
<!--# 3. Create Virtual Environment-->
<!--#########################################################################################-->

<!--## Create virtual env - eksAdmin-->

<!--conda env create -f environment.yml-->

<!--conda env list-->
<!--# conda environments:-->
<!--#-->
<!--eksAdmin                 /home/ec2-user/.conda/envs/eksAdmin-->
<!--base                  *  /opt/conda-->

<!--#conda remove --name eksAdmin --all-->

<!--conda activate eksAdmin-->


<!--pip --version-->

<!--# Upgrade pip-->
<!--pip install --upgrade pip-->







#########################################################################################
# 9. (eksAdmin) Install aws-iam-authenticator
#########################################################################################

bash config/install-aws-iam-authenticator.sh