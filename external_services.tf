/* 
    External Services
    Develop By: William MR
*/

resource "kubernetes_service" "rds" {
  metadata {
    name = "timeoff-database"
  }

  spec {
    type = "ExternalName"
    external_name = element(split(":", module.db.this_db_instance_endpoint), 0)
  }
}