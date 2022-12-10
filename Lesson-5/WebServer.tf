#-----------------------------
#My terraform
#
#Build WebServer during Bootstrap with lifecycle resourses and Zero DownTime
#
#Made by Anvar
#------------------------------

provider "aws" {}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
  vpc      = true # Need to add in new AWS Provider version
  tags = {
    Name  = "Web Server IP"
    Owner = "Anvar Kalykov"
  }
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0b0dcb5067f052a63"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Anvar"
    l_name = "Kalykov"
    names  = ["Arman", "Serik", "Nurs", "Markha", "Erkin", "Test", "Test1"]
  })
  user_data_replace_on_change = true

  tags = {
    Name  = "Web Server Build by terraform"
    Owner = "Anvar"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "Security Group gor WebServer"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id


  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

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
