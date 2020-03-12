# Multi-cloud-k8-demo
A terraform module to create a basic MariaDB SQL service and the Transit APP that is configured to use Dynamic Secrets and Transit Encryption using Vault. To conect these service Consul is configuread as a service registory.

## Usage

```hcl
terraform {
  required_version = ">= 0.12"
}
#AWS
module "Cluster_EKS" {
  source       = "./Cluster_EKS"
  cluster-name = "eks-k8-demo"

}
# #MSFT
module "Cluster_AKS" {
  source       = "./Cluster_AKS"
  cluster-name = "aks-k8-demo"

}
#Google
module "Cluster_GKE" {
  source       = "./Cluster_GKE"
  cluster_name = "gke-k8-demo"
  gcp_project  = "project-name"
  gcp_region   = "australia-southeast1"

}
```
## Pre-requirements 
Before you run this you will need to:

1.You will need to auth to GCP,Azure and AWS

2.Install helm V2 **if you use helm version 3 the tiller install will fail**

3.Install aswcli v2 https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html 

4.Install GKE SDK https://cloud.google.com/sdk/docs/downloads-interactive 

5.Insall Azure Cli https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos?view=azure-cli-latest 

## NOTE:If you are re-running this demo for a second time please check to see if app_stack/app_<cloud>/vault/init.txt exists. If it does please is remove it before running the setup scripts.

## Inputs
### AKS
You will need to set the following variables to be relevant to your envrioment:

variable "appId" 
  default = "41111111111111111111111"

variable "password" 
  default = "c3444444444444444444444444444444"

variable "location" 
  default = "Australia East"

### EKS
You will need to set the following variables to be relevant to your envrioment:

variable "aws_region" 

### GKS
You will need to set the following variables to be relevant to your envrioment:

variable "gcp_region" 
  description = "GCP region, e.g. us-east1"
  default     = "australia-southeast1"

variable "gcp_zone" 
  description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
  default     = "australia-southeast1-c"

variable "gcp_project" {
  description = "GCP project name"
  default     = "your-project-name"
}


### Main.tf
Here you can name the clusters by altering the following:
cluster_name = "your-name"

## Outputs
The Terraform will locally install the user creds into your kubectl config file so that you can switch between the clusters use the kubectl config get-contexts command to see cluster names


### App deployment

Use the kubectl config user-context <name> to set the enviroment you wish to deploy too.
CD into the main app_stack directory in there you will see app_<cloud> stacks which are cloud specifc namaged K8 clusters. CD into the enviroment you wish to deploy too and run

./full_stack_deploy.sh

run kubectl get svc to see the EXTERNAL-IP to connect to for the service.


### What you get!

You can connect to the consul UI and see the services registerd using http://<EXTERNAL-IP>

it should look like this:

![]/images/consul.png

You can connect to the Vault UI and see the secrets engines enabled using http://<EXTERNAL_IP:8200>

You will need to login in using the ROOT TOKEN from the init.txt file located in app_stack/app_<cloud>/vault/init.txt to authenticate

it should look like this:






