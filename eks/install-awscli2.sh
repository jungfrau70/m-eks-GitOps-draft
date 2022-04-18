#!/bin/bash

# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
rm -rf aws
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf  awscliv2.zip aws

aws --version
