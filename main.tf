resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name_prefix = "${var.project}-${var.environment}-"
  public_key      = tls_private_key.key.public_key_openssh
  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./ssh.pem ; chmod 400 ./ssh.pem"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ./ssh.pem"
  }
}

resource "aws_security_group" "packer" {
  name_prefix = "${var.project}-${var.environment}-"
  description = "allow all"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "packer" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  region                 = var.region 
  key_name               = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.packer.id]
  tags = {
    "Name"        = "${var.project}-${var.environment}-packer"
    "project"     = var.project
    "environemnt" = var.environment
  }
  provisioner "local-exec" {
    command = "echo 'ssh -i ${path.cwd}/ssh.pem ec2-user@${aws_instance.packer.public_ip}' > ./instance_ssh_auth.txt"
  }
}
