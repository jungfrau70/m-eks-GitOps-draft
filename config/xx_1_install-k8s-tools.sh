#!/bin/bash
# https://www.eksworkshop.com/020_prerequisites/k8stools/
sudo curl --silent --location -o /usr/local/bin/kubectl    https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.11/2020-09-18/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
kubectl version
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
sudo pip3 install --upgrade awscli && hash -r
sudo yum install python37
python3 --version
curl -O https://bootstrap.pypa.io/get-pip.py
aws --version
pip3 install --upgrade --user awscli
export PATH=$HOME/.local/bin:$PATH
source ~/.bash_profile
aws --version
aws --version
sudo yum -y install jq gettext bash-completion moreutils
echo 'yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc
for command in kubectl jq envsubst aws;   do     which $command &>/dev/null && echo "$command in path" || echo "$command NOT FOUND";   done
kubectl completion bash >>  ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
echo 'export LBC_VERSION="v2.0.0"' >>  ~/.bash_profile
.  ~/.bash_profile
