provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "lambda.create.me.on-1662893034.3455179"
    key = "globalvars/terraform.tfstate"
    region = "eu-west-1"
  }
}

locals {
  company_name = data.terraform_remote_state.global.outputs.company_name
  owner = data.terraform_remote_state.global.outputs.owner
  common_tags = data.terraform_remote_state.global.outputs.tags

}

resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = "Stack1-VPC1"
    Company = local.company_name
    Owner   = local.owner
  }
}


resource "aws_vpc" "vpc2" {
  cidr_block = "10.0.0.0/16"
  tags       = merge(local.common_tags, { Name = "Stack1-VPC2" })
}