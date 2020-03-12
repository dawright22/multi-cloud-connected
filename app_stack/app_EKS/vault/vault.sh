#!/bin/bash
set -v

# Clone the repo
helm install  --name=vault -f ./values.yaml ./vault-helm

sleep 30s




