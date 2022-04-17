#!/bin/bash

## Update packages of the instance
sudo yum -y update

## Install Anaconda in silent mode
wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
sudo bash Anaconda3-2021.11-Linux-x86_64.sh -b -p /opt/conda
rm -rf Anaconda3-2021.11-Linux-x86_64.sh 

## Initialize Conda
eval "$(/opt/conda/bin/conda shell.bash hook)"
conda init
cat ~/.bashrc

## (If required) add ENV in .bashrc
cat >>~/.bashrc<<EOF
export PATH=$PATH:/opt/conda/bin/
EOF