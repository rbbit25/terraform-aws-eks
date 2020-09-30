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

/*
  Database Secret Data
*/

data "aws_secretsmanager_secret" "db_endpoint" {
  name = "DB_ENDPOINT"
}

data "aws_secretsmanager_secret" "db_name" {
  name = "DB_NAME"
}

data "aws_secretsmanager_secret_version" "db_name" {
  secret_id = data.aws_secretsmanager_secret.db_name.id
}

data "aws_secretsmanager_secret" "db_username" {
  name = "DB_USERNAME"
}

data "aws_secretsmanager_secret_version" "db_username" {
  secret_id = data.aws_secretsmanager_secret.db_username.id
}

data "aws_secretsmanager_secret" "db_password" {
  name = "DB_PASSWD"
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}