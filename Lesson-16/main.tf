#----------------------------------------------------------
# My Terraform
#
# Terraform Conditions and Lookups
#
# Made by Anvar
#----------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_instance" "my-server" {
  ami = "ami-0b0dcb5067f052a63"
  //instance_type = var.env == "prod" ? "t3.micro" : "t2.micro"
  instance_type = var.env == "prod" ? var.ec2_size["prod"] : var.ec2_size["dev"]

  tags = {
    Name = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.no-prod_owner
  }
}

resource "aws_instance" "bastion" {
  count = var.env == "dev" ? 1 : 0
  ami = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"

  tags = {
    Name = "Bastion-server"
  }
}

resource "aws_instance" "my-server_lookup" {
  ami = "ami-0b0dcb5067f052a63"
  instance_type = lookup(var.ec2_size, var.env)

  tags = {
    Name = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.no-prod_owner
  }
}


resource "aws_security_group" "my_webserver" {
  name   = "Dynamic Security Group"
  vpc_id = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SecurityGroup"
    Owner = "Anvar"
  }
}

