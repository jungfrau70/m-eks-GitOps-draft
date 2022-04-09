#!/bin/bash
# https://www.eksworkshop.com/020_prerequisites/sshkey/

# Press return for all questions by keeping the defaults and empty passphrase.
ssh-keygen

# Import key-pair, eks into EC2(Cloud9)
aws ec2 import-key-pair --key-name "eks" --public-key-material file://~/.ssh/id_rsa.pub
