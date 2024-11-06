packer {
  required_plugins {
    amazon = {
      version = "~> 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "boundary_version" {
  type    = string
  default = "0.18.0+ent"
}

variable "application_name" {
  type    = string
  default = "boundary"
}

data "amazon-ami" "ubuntu20" {
  filters = {
    architecture                       = "x86_64"
    "block-device-mapping.volume-type" = "gp2"
    name                               = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    root-device-type                   = "ebs"
    virtualization-type                = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
  region      = "${var.aws_region}"
}

source "amazon-ebs" "ubuntu20-ami" {
  ami_description             = "An Ubuntu 20.04 AMI that has Boundary Enterprise installed."
  ami_name                    = "boundary-ubuntu-${formatdate("YYYYMMDDhhmm", timestamp())}"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  region                      = "${var.aws_region}"
  source_ami                  = "${data.amazon-ami.ubuntu20.id}"
  ssh_username                = "ubuntu"
  tags = {
    application     = "${var.application_name}"
    consul_version  = "${var.boundary_version}"
    owner           = "tphan@hashicorp.com"
    packer_source   = "https://github.com/phan-t/terraform-hcp-boundary-vault-amp/blob/master/examples/amis/boundary/boundary.pkr.hcl"
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu20-ami"]

  provisioner "shell" {
    inline = [
      // "sudo mkdir -p /etc/pki/tls/boundary/",
      "git clone https://github.com/phan-t/terraform-hcp-boundary-vault-amp.git /tmp/terraform-hcp-boundary-vault-amp",
      "/tmp/terraform-hcp-boundary-vault-amp/examples/amis/boundary/scripts/install-boundary --version ${var.boundary_version}"
    ]
  }
}