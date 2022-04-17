#!/bin/bash
# https://www.eksworkshop.com/020_prerequisites/k8stools/

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
