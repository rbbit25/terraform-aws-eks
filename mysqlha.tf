/*
    MySQL HA with Helm
    Develop By: William MR
*/

resource "helm_release" "timedb" {
  name       = "timedb"
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  chart      = "mysqlha"

  set {
      name = "mysqlDatabase"
      value = "timeoffdb"
  }

  set {
      name = "mysqlUser"
      value = "testuser"
  }

  set {
      name = "mysqlPassword"
      value = "testpassword"
  }
}