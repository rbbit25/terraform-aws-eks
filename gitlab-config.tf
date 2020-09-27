/* 
  GitLab Configuration
  Develop By: William MR
*/

resource "kubernetes_service_account" "gitlab" {
  metadata {
    name        = "gitlab"
    namespace   = "kube-system"
  }
}

resource "kubernetes_role_binding" "gitlab" {
  metadata {
    name      = "gitlab-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "admin"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "gitlab"
    namespace = "kube-system"
  }
}
