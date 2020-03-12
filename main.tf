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
}
