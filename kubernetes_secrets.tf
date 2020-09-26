/* 
    EKS Secrets for RDS Database
    Develop By: William MR
*/

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.current.secret_string
  )
}

resource "kubernetes_secret" "rds-db-credentials" {
    metadata {
        name = "rds-db-credentials"
    }

    data = {
        db_name     = local.db_creds.db_name
        db_username = local.db_creds.db_username
        db_password = local.db_creds.db_password
        db_host     = module.db.this_db_instance_endpoint
        db_dialect  = "mysql"
    }

    type = "kubernetes.io/basic-auth"
}