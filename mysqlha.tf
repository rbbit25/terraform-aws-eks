/*
    MySQL HA with Helm
    Develop By: William MR
*/

resource "helm_release" "timedb" {
  name       = "timedb"
  repository = data.helm_repository.incubator.metadata[0].name
  chart      = "mysqlha"
}