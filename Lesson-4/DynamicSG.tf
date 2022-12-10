#-----------------------------
#My terraform
#
#Dynamic Security Group
#
#Made by Anvar
#------------------------------

provider "aws" {}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "Security Group gor WebServer"



  dynamic "ingress" {
    for_each = ["80", "443", "8080", "7777", "8888"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }


  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]

  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG for WebServer"
  }
}
