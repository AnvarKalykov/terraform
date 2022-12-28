#----------------------------------------------------------
# My Terraform
#
# Global Variables in Remote State on S3
#
# Made by Anvar
#----------------------------------------------------------

provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "lambda.create.me.on-1662893034.3455179"
    key = "globalvars/terraform.tfstate"
    region = "eu-west-1"
  }
}

#==================================================

output "company_name" {
  value = "Serik"
}

output "owner" {
  value = "Anvar"
}

output "tags" {
  value = {
    Project    = "AK"
    CostCenter = "R"
    Country    = "Poland"
  }
}