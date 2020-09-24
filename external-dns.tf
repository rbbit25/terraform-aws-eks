/* 
    EKS Policy for External DNS
    Develop By: William MR
*/

/*
locals {
  oidc_url = replace(module.eks-cluster.cluster_oidc_issuer_url, "https://", "")
}
*/

resource "aws_iam_role" "external_dns" {
  name                = "${module.eks-cluster.cluster_id}-external-dns"
  assume_role_policy  = file("aws-policy/external-dns-iam-policy.json")
}

/*
resource "aws_iam_role_policy" "external_dns" {
  name_prefix = "${module.eks-cluster.cluster_id}-external-dns"
  role = aws_iam_role.external_dns.name
  policy = file("aws-policy/external-dns-iam-policy.json")
}
*/

resource "kubernetes_service_account" "external_dns" {
  metadata {
    name = "external-dns"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.external_dns.arn
    }
  }
  automount_service_account_token = true
}

resource "kubernetes_cluster_role" "external_dns" {
  metadata {
    name = "external-dns"
  }

  rule {
    api_groups  = [""]
    resources   = ["services", "pods", "nodes"]
    verbs       = ["get", "list", "watch"]
  }

  rule {
    api_groups  = ["extensions", "networking.k8s.io"]
    resources   = ["ingresses"]
    verbs       = ["get", "list", "watch"]
  }

  rule {
    api_groups  = ["networking.istio.io"]
    resources   = ["gateways"]
    verbs       = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "external_dns" {
  metadata {
    name = "external-dns"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = kubernetes_cluster_role.external_dns.metadata.0.name
  }

  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.external_dns.metadata.0.name
    namespace = kubernetes_service_account.external_dns.metadata.0.namespace
  }
}