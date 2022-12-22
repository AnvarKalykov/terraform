variable "env" {
  default = "prod"
}

variable "prod_owner" {
  default = "Anvar"
}

variable "no-prod_owner" {
  default = "Serik"
}

variable "ec2_size" {
  type = map
  default = {
    "prod" = "t3.medium"
    "dev" = "t3.micro"
    "stag" = "t2.small"
  }
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "443", "8080", "22"]
  }
}