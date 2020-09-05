/* 
    Terraform State Configuration
    Develop By: William MR
*/

terraform { 
    backend "s3" {
        bucket          = "terraform.hachiko.app"
        key             = "terraform-aws-eks/state"
        region          = "us-east-1"
        dynamodb_table  = "terraform-state-01"
        encrypt         = true
    }
}
