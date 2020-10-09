/* 
    External Services
    Develop By: William MR
*/

resource "kubernetes_service" "rds" {
  metadata {
    name = "timeoff_database"
  }

  spec {
    type = "ExternalName"
    externalName = element(split(":", module.db.this_db_instance_endpoint), 0)
  }
}