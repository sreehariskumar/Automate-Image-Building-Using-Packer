variable "project" {
  default = "zomato"
}

variable "environment" {
  default = "prod"
}

variable "access_key" {
  default = XXXXXXXXXX
}

variable "secret_key" {
  default = xxxxxxxxxx
}

variable "mumbai" {
  default = "ap-south-1"
}

variable "ohio" {
  default = "us-east-2"
}

#Amazon Linux 2 AMI
variable "mumbai_ami" {
  default = "ami-0cca134ec43cf708f"
}

#Ubuntu 18.04 AMI
variable "ohio_ami" {
  default = "ami-071c33e7823c066b5"
}

locals {
  image-timestamp = "${formatdate("DD-MM-YYYY-hh-mm", timestamp())}"
  image-name = "${var.project}-${var.environment}-${local.image-timestamp}"
}
