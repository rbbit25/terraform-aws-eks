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

data "aws_secretsmanager_secret" "secrets" {
  name = "mysql_secrets"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.current.secret_string
  )
}

data "aws_secretsmanager_secret" "db_endpoint" {
  name = "DB_ENDPOINT"
}