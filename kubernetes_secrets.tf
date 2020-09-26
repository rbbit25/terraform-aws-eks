/* 
    EKS Secrets for RDS Database
    Develop By: William MR
*/
resource "kubernetes_secret" "rds-db-credentials" {
    metadata {
        name = "rds-db-credentials"
    }

    data = {
        db_name     = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["db_name"]
        db_username = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["db_username"]
        db_password = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["db_password"]
        db_host     = module.db.this_db_instance_endpoint
        db_dialect  = "mysql"
    }

    type = "kubernetes.io/basic-auth"
}