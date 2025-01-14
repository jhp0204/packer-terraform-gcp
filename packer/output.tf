output "image_name" {
    value = "${var.image_name}-${local.timestamp}"
}

output "image_id" {
    value = data.aws_ami.latest-packer.image_id
}
