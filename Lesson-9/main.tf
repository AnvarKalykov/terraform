

#----------------------------------------------------------
# My Terraform
#
# Find Latest AMI id of:
#    - Ubuntu 22.04
#    - Amazon Linux 2
#    - Windows Server 2016 Base
#
# Made by Anvar
#-----------------------------------------------------------


provider "aws" {

}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazon" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

// How to use
/*
resource "aws_instance" "my_webserver_with_latest_ubuntu_ami" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
}
*/


output "latest_amazon_linux_ami_id" {
  value = data.aws_ami.latest_amazon.id
}

output "latest_amazon_linux_ami_name" {
  value = data.aws_ami.latest_amazon.name
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}
