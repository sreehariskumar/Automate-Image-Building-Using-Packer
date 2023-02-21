source "amazon-ebs" "mumbai" {
  region = var.mumbai
  access_key = var.access_key
  secret_key = var.secret_key
  ami_name = local.image-name
  source_ami  = var.mumbai_ami
  instance_type = "t2.micro"
  ssh_username = "ec2-user"
  tags = {
    Name = local.image-name
    project = var.project
    environment =  var.environment
  }  
}

source "amazon-ebs" "ohio" {
   region = var.ohio
   access_key = var.access_key
   secret_key = var.secret_key
   ami_name = local.image-name
   source_ami  = var.ohio_ami
   instance_type = "t2.micro"
   ssh_username = "ubuntu"   
   tags = {
     Name = local.image-name
     project = var.project
     environment =  var.environment
   }  
}

build {
  sources = [ "source.amazon-ebs.mumbai" ]
  provisioner "shell" {
    script = "./httpd.sh"
    execute_command  = "sudo  {{.Path}}"
  }    
}

build {
  sources = [ "source.amazon-ebs.ohio" ]
  provisioner "shell" {
    script = "./apache.sh"
    execute_command  = "sudo  {{.Path}}"
  }    
}
