#!/bin/bash

# Install Helm3
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Check the version
helm version --short

# Download the stable repo
helm repo add stable https://charts.helm.sh/stable

# List the charts
helm search repo stable

# Configure Bash completion for the helm command
helm completion bash >> ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
source <(helm completion bash)
