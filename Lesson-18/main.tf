#----------------------------------------------------------
# My Terraform
#
# Provision Resources in Multiply AWS Regions / Accounts
#
# Made by Anvar
#----------------------------------------------------------

provider "aws" { // This is example to use Another AWS Account
  alias      = "ANOTHER_AWS_ACCOUNT"
  region     = "ca-central-1"
  access_key = "xxxxxxxxxxxx"
  secret_key = "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"

  assume_role {
    role_arn     = "arn:aws:iam::1234567890:role/RemoteAdministrators"
    session_name = "TERRAFROM_SESSION"
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "eu-west-2"
  alias = "London"
}

resource "aws_instance" "my_default_server" {
  instance_type = "t2.micro"
  ami = "ami-0b0dcb5067f052a63"

  tags = {
    Name = "Default Server"
  }
}

resource "aws_instance" "my_London_server" {
  provider = aws.London
  instance_type = "t2.micro"
  ami = "ami-084e8c05825742534"

  tags = {
    Name = "London Server"
  }
}