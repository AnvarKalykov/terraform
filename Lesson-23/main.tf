provider "aws" {

}


resource "aws_instance" "my_ubuntu" {
  count         = 1
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  tags = {
    Name  = "Web Server Build by ${terraform.workspace}"
    Owner = "Anvar"
  }
}
