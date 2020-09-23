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

  name                  = var.rds_name
  username              = var.rds_username
  password              = var.rds_password
  port                  = var.rds_port

  vpc_security_group_ids = [aws_security_group.sec_grp_rds.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  
  # disable backups to create DB faster
  backup_retention_period = 0

  # DB subnet group
  subnet_ids = module.vpc.public_subnets

  # DB parameter group
  family = var.rds_parameter_group_name
}