#!/bin/bash
# https://www.eksworkshop.com/020_prerequisites/workspaceiam/

# install some utilities
sudo yum -y install jq gettext bash-completion moreutils

# go the settings, AWS settings and turn off temporary credentials
rm -vf ${HOME}/.aws/credentials

# configure aws env variables
# The following get-caller-identity example displays information about the IAM identity used to authenticate the request
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set
echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region
aws sts get-caller-identity --query Arn | grep eksAdminRole -q && echo "IAM role valid" || echo "IAM role NOT valid"
