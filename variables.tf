variable "project" {
  default = "zomato"
}

variable "environment" {
  default = "prod"
}

variable "region" {
  default = "ap-south-1"
}

variable "access_key" {
  default = XXXXXXXXXX
}

variable "secret_key" {
  default = XXXXXXXXXX
}

variable "instance_type" {
  default = "t2.micro"
}

locals {
  common_tags = {
    project     = var.project
    environment = var.environment
  }
}
