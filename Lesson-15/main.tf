#----------------------------------------------------------
# My Terraform
#
# Generate Password
# Store Password in SSM Parameter Store
# Get Password from SSM Parameter Store
# Example of Use Password in RDS
#
# Made by Anvar
#----------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

resource "random_string" "rds_paasword" {
  length = 12
  special = true
  override_special = "!#$&"

  keepers = {
    kepeer1 = var.name
    //keperr2 = var.something
  }
}

resource "aws_ssm_parameter" "rds_ssm_password" {
  description = "Master Password for RDS MySQL"
  name  = "/prod/mysql"
  type  = "SecureString"
  value = random_string.rds_paasword.result
}

data "aws_ssm_parameter" "my_rds_password" {
  name = "/prod/mysql"
  depends_on = [aws_ssm_parameter.rds_ssm_password]
}

resource "aws_db_instance" "default" {
  identifier           = "prod-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "prod"
  username             = "administrator"
  password             = data.aws_ssm_parameter.my_rds_password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
}

