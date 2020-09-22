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
      value = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["db_username"]
  }

  set {
      name = "mysqlPassword"
      value = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["db_password"]
  }
}