source "amazon-ebs" "basic-example" {
  region        =  "us-east-1"
  source_ami    =  "ami-fce3c696"
  instance_type =  "t2.micro"
  ssh_username  =  "ubuntu"
  ami_name      =  "packer_AWS_jhp0204_{{timestamp}}"
  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
    http_put_response_hop_limit = 1
  }
}

build {
  name = "packer"
  source "sources.amazon-ebs.basic-example" {
      name = "packer"
  }

  provisioner "file"{
    source = "./files"
    destination = "/tmp/"
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
