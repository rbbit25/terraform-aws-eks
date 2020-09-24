/* 
    Project Tags
    Develop By: William MR
*/

variable "aws_account_id" {
    description = "AWS Account Id Number"
}

variable "project_owner" {
    description     = "Tag to identify the resource owner name"
    default         = "William Munoz Rodas"
}

variable "project_email" {
    description     = "Tag to identify the resource owner email"
    default         = "william.munozr@gmail.com"
} 

variable "project_name" {
    description     = "Tag to identify the resource project name"
    default         = "Kubernetes"
}

variable "is_project_terraformed" {
    description     = "Tag to identify if the project is managed by Terraform"
    default         = "true"
}

/* Region */

variable "region" {
    type            = map(string)
    default         = {
        "development"   = "us-east-2"
        "qa"            = "us-east-1"
        "staging"       = "us-east-2"
        "production"    = "us-east-2"
    }
}

/* Environment Definition */

variable "environment" {
    description     = "Environment Definition - Options: development, qa, staging, production"
    default         = "development"
}

/* VPC Configuration */

variable "vpc_name" {
    description     = "VPC Name"
    default         = "terraform-eks-01"
}

variable "cidr_ab" {
    type = map
    default = {
        development = "172.20"
        qa          = "172.21"
        staging     = "172.22"
        production  = "172.23"
    }
}

locals {
  cidr_c_private_subnets    = 1
  cidr_c_public_subnets     = 64

  max_private_subnets       = 1
  max_public_subnets        = 3
}

locals {
    availability_zones  = data.aws_availability_zones.available.names
}

/* Subnets Configuration */

locals {
    private_subnets = [
        for az in local.availability_zones :
            "${lookup(var.cidr_ab, var.environment)}.${local.cidr_c_private_subnets + index(local.availability_zones, az)}.0/24"
            if index(local.availability_zones, az) < local.max_private_subnets
    ]

    public_subnets = [
        for az in local.availability_zones :
            "${lookup(var.cidr_ab, var.environment)}.${local.cidr_c_public_subnets + index(local.availability_zones, az)}.0/24"
            if index(local.availability_zones, az) < local.max_public_subnets
    ]
}

/* EKS Cluster */
variable "eks_cluster_name" {
    description     = "EKS Cluster Name"
    default         = "eks-cluster"
}

variable "eks_cluster_version" {
    description     = "EKS Cluster Version"
    default         = "1.17"
}

# variable "external_dns_chart_version" {
#   description = "External-dns Helm chart version to deploy. 3.0.0 is the minimum version for this function"
#   type        = string
#   default     = "3.0.0"
# }

# variable "external_dns_chart_log_level" {
#   description = "External-dns Helm chart log level. Possible values are: panic, debug, info, warn, error, fatal"
#   type        = string
#   default     = "warn"
# }

# variable "external_dns_zoneType" {
#   description = "External-dns Helm chart AWS DNS zone type (public, private or empty for both)"
#   type        = string
#   default     = ""
# }

# variable "external_dns_domain_filters" {
#   description   = "External-dns Domain filters."
#   type          = list(string)
#   default       = ["kubernetesops.com"]
# }

/* EKS Wordpress Worker Nodes */
variable "eks_instance_type" {
    description     = "EKS Instance Type"
    default         = "t2.medium"
}

/* EKS Auto Scaling Group Max Size */
variable "eks_asg_max_size" {
    description     = "EKS Auto Scaling Group Max Size"
    default         = 3
}

variable "asg_desired_capacity" {
    description     = "Desired Capacity"
    default         = 3
}

###
# RDS Configuration
###
variable "rds_database_identifier" {
  description = "RDS Database Identifier"
  default     = "terraform-eks-01"
}

variable "rds_port" {
  default = "3306"
}

variable "rds_storage_type" {
  default = "gp2"
}

variable "rds_allocated_storage" {
  default = "10"
}

variable "rds_engine" {
  default = "mysql"
}

variable "rds_engine_version" {
  default = "5.7.19"
}

variable "rds_instance_class" {
  default = "db.t2.medium"
}

variable "rds_parameter_family" {
  default = "mysql5.7"
}

variable "enable_dashboard" {
  default = true
}

variable "rds_major_engine_version" {
  default = "5.7"
}