provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "lambda.create.me.on-1662893034.3455179"
    key = "dev/network/terraform.tfstate"
    region = "eu-west-1"
  }
}

data "aws_availability_zones" "available" {

}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-VPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-IGW"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_ciders)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnet_ciders, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.env}-route-public-subnets"
  }
}

resource "aws_route_table_association" "public_routes" {
  count = length(aws_subnet.public_subnet[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id = element(aws_subnet.public_subnet[*].id, count.index)
}