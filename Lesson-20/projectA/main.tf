provider "aws" {
  region = "eu-west-2"
}

module "vpc-default" {
  source = "../modules/aws_network"
}

module "vpc-dev" {
  source = "../modules/aws_network"
  env = "development"
  vpc_cidr = "10.100.0.0/16"
  public_subnet_ciders = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_ciders = ["10.100.11.0/24", "10.100.11.0/24"]
}

module "vpc-prod" {
  source = "../modules/aws_network"
  env = "production"
  vpc_cidr = "10.10.0.0/16"
  public_subnet_ciders = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnet_ciders = ["10.10.11.0/24", "10.10.11.0/24"]
}

#------------------------------


