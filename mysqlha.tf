/*
    MySQL HA with Helm
    Develop By: William MR
*/

# resource "helm_release" "mysqlha" {
#   name       = "mysqlha"
#   repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
#   chart      = "mysqlha"
#   reset_values = true
#   recreate_pods = true

#   set {
#       name = "mysqlDatabase"
#       value = "mysqlha"
#   }

#   set {
#       name = "mysqlUser"
#       value = data.aws_secretsmanager_secret_version.db_name.secret_string
#   }

#   set {
#       name = "mysqlPassword"
#       value = data.aws_secretsmanager_secret_version.db_password.secret_string
#   }
# }