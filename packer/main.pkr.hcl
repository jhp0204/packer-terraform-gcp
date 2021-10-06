source "amazon-ebs" "basic-example" {
  region        =  "us-east-1"
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
      "pwd"
    ]
  }
}
