##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################

resource "aws_security_group" "sec_grp_rds" {
  name_prefix = "${module.eks-cluster.cluster_id}-"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "allow-workers-nodes-communications" {
  description              = "Allow worker nodes to communicate with database"
  from_port                = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sec_grp_rds.id
  source_security_group_id = module.eks-cluster.worker_security_group_id
  to_port                  = 3306
  type                     = "ingress"
}

#####
# DB
#####
module "db" {
  version               = "v2.18.0"
  source                = "terraform-aws-modules/rds/aws"

  identifier            = var.rds_database_identifier

  engine                = var.rds_engine
  engine_version        = var.rds_engine_version
  instance_class        = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  storage_encrypted     = false
  publicly_accessible   = true

  name                  = local.db_creds.db_name
  username              = local.db_creds.db_username
  password              = local.db_creds.db_password
  port                  = var.rds_port

  vpc_security_group_ids = [aws_security_group.sec_grp_rds.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Disable backups to create DB faster
  backup_retention_period = 0

  # DB subnet group
  subnet_ids = module.vpc.public_subnets

  deletion_protection = false

  major_engine_version = var.rds_major_engine_version

  family = var.rds_parameter_family
}

####
# Update the RDS Endpoint
####
resource "aws_secretsmanager_secret_version" "db_endpoint" {
  secret_id     = data.aws_secretsmanager_secret.db_endpoint.id
  secret_string = module.db.this_db_instance_endpoint
}