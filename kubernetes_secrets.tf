/* 
    EKS Secrets for RDS Database
    Develop By: William MR
*/

resource "kubernetes_secret" "rds-db-credentials" {
    metadata {
        name = "rds-db-credentials"
    }

    data = {
        db_host = module.db.this_db_instance_endpoint
    }

    type = "kubernetes.io/basic-auth"
}