/*
    MySQL HA with Helm
    Develop By: William MR
*/

resource "helm_release" "timedb" {
  name       = "timedb"
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  chart      = "mysqlha"
  reset_values = true
  recreate_pods = true

  set {
      name = "mysqlDatabase"
      value = "timeoffdb"
  }

  set {
      name = "mysqlUser"
      value = data.aws_secretsmanager_secret.by-name.db_username
  }

  set {
      name = "mysqlPassword"
      value = data.aws_secretsmanager_secret.by-name.db_password
  }
}