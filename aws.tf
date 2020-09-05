/*
    Providers
    Develop By: William MR
*/

provider "aws" {
    region = lookup(var.region, var.environment)
}