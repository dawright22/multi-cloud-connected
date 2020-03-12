#!/bin/bash
set -v

echo "Installing Consul from Helm chart repo..."
git clone https://github.com/hashicorp/consul-helm.git
helm install --name=consul -f ./values.yaml ./consul-helm

sleep 10s

kubectl apply -f stubDomain.yaml


sleep 20s
