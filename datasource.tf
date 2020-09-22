/*
  Datasources
  Develop By: William MR
*/

data "aws_availability_zones" "available" {
    state = "available"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks-cluster.cluster_id
}

# data "helm_repository" "incubator" {
#   name = "incubator"
#   url  = "https://kubernetes-charts-incubator.storage.googleapis.com"
# }