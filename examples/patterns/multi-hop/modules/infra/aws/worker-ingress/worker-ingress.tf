locals {
  key_pair_private_key = file("../../../${var.deployment_id}.pem")
}

data "aws_ami" "boundary" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["boundary-*"]
  }

  filter {
    name   = "tag:application"
    values = ["boundary"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${var.deployment_id}-public*"]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "tag:Name"
    values = ["${var.deployment_id}-ssh"]
  }
}

resource "local_file" "worker-ingress-config" {
  content = templatefile("${path.root}/templates/worker-ingress.hcl.tpl", {
    public_ip = aws_instance.worker-ingress.public_ip
    hcp_boundary_cluster_id = var.hcp_boundary_cluster_id
    token = boundary_worker.ingress.controller_generated_activation_token
    })
  filename = "${path.module}/configs/worker-ingress.hcl"
}

resource "aws_instance" "worker-ingress" {
  ami             = data.aws_ami.boundary.id
  instance_type   = "t2.small"
  key_name        = var.deployment_id
  subnet_id       = element(data.aws_subnets.public.ids, 1)
  security_groups = [data.aws_security_group.ssh.id, module.sg-boundary-worker-ingress.security_group_id]

  lifecycle {
    ignore_changes = all
  }
  
  tags = {
    Name  = "${var.deployment_id}-boundary-worker-ingress"
  }
}

resource "null_resource" "worker-ingress" {
  connection {
    host          = aws_instance.worker-ingress.public_dns
    user          = "ubuntu"
    agent         = false
    private_key   = local.key_pair_private_key
  }

  provisioner "file" {
    source      = "${path.module}/configs/worker-ingress.hcl"
    destination = "/var/tmp/worker-ingress-config.hcl"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /var/tmp/worker-ingress-config.hcl /opt/boundary/config/boundary-worker.hcl",
      "sudo /opt/boundary/bin/run-boundary worker"
    ]
  }

  depends_on = [ 
    local_file.worker-ingress-config 
  ]
}