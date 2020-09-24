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

data "aws_iam_policy_document" "external_dns" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "route53:ChangeResourceRecordSets",
    ]

    resources = [
      "arn:aws:route53:::hostedzone/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]

    resources = [
      "*",
    ]
  }
}