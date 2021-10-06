packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
source "amazon-ebs" "basic-example" {
  region        =  "us-east-1"
  vpc_id        =  "vpc-d8ce66a5"
  subnet_id     =  "subnet-80c3efcd" 
  source_ami    =  "ami-fce3c696"
  instance_type =  "t2.micro"
  associate_public_ip_address = true
  ssh_username  =  "ubuntu"
  ssh_interface =  "public_ip"
  ami_name      =  "packer_AWS_jhp0204_{{timestamp}}"
  
}

build {
  name = "packer"
  source "sources.amazon-ebs.basic-example" {
      name = "packer"
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get -y update",
      "sleep 15",
      "sudo apt-get -y update",
      "sudo apt-get -y install apache2",
      "sudo systemctl enable apache2",
      "sudo systemctl start apache2",
      "sudo chown -R ubuntu:ubuntu /var/www/html",
      "chmod +x /tmp/files/*.sh",
      "PLACEHOLDER=${var.placeholder} WIDTH=600 HEIGHT=800 PREFIX=gs /tmp/files/deploy_app.sh",
    ]
  }
}
