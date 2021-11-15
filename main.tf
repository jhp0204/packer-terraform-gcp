data "terraform_remote_state" "image_name" {
  backend = "remote"

  config = {
    organization = "jhp0204"
    workspaces = {
      name = "PACKER-terraform-gcp"
    }
  }
}

resource "aws_instance" "jenkins-demo" {
  count         = "1"
  ami           = data.terraform_remote_state.image_name.outputs.image_name
  instance_type = "t2.micro"

  tags {
    Name  = "Packer-test"
  }

  key_name  = "jhp0204"
}
