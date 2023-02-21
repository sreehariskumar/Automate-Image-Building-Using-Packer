data "aws_ami" "ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["${var.project}-${var.environment}-*"]
  }

  filter {
    name   = "tag:project"
    values = [var.project]
  }

  filter {
    name   = "tag:environment"
    values = [var.environment]
  }
}
