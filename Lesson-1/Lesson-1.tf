provider "aws" {

}


resource "aws_instance" "my_ubuntu" {
  count         = 3
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
}



resource "aws_instance" "my_amazon" {
  count         = 1
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
}
