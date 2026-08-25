locals {
  key_pair_private_key = file("../../../${var.deployment_id}.pem")
}

data "aws_ami" "ubuntu20" {

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["099720109477"]
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["${var.deployment_id}-private*"]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "tag:Name"
    values = ["${var.deployment_id}-ssh"]
  }
}

resource "aws_instance" "http-web" {
  ami             = data.aws_ami.ubuntu20.id
  instance_type   = "t2.small"
  key_name        = var.deployment_id
  subnet_id       = element(data.aws_subnets.private.ids, 1)
  security_groups = [data.aws_security_group.ssh.id, module.sg-http-web.security_group_id]

  lifecycle {
    ignore_changes = all
  }
  
  tags = {
    Name  = "${var.deployment_id}-http-web"
  }
}

resource "null_resource" "http-web" {
  connection {
    host          = aws_instance.http-web.private_dns
    user          = "ubuntu"
    agent         = false
    private_key   = local.key_pair_private_key
    bastion_host  = var.bastion_public_fqdn
  }

  provisioner "remote-exec" {
    inline = [
      "sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse'",
      "sudo apt update -y",
      "sudo apt install apache2 -y"
    ]
  }
}