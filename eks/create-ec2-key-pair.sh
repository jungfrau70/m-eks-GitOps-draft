#!/bin/bash

# Create ssh-key
# Press return for all questions by keeping the defaults and empty passphrase.
ssh-keygen -t rsa

# Import key-pair using newly created public key on Cloud9
aws ec2 import-key-pair --key-name "cloud9" --public-key-material file://~/.ssh/id_rsa.pub
