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

resource "local_file" "worker-egress-config" {
  content = templatefile("${path.root}/templates/worker-egress.hcl.tpl", {
    private_ip = aws_instance.worker-egress.private_ip
    upstream_worker_private_ip = var.upstream_worker_private_ip
    token = boundary_worker.egress.controller_generated_activation_token
    })
  filename = "${path.module}/configs/worker-egress.hcl"
}

resource "aws_instance" "worker-egress" {
  ami             = data.aws_ami.boundary.id
  instance_type   = "t2.small"
  key_name        = var.deployment_id
  subnet_id       = element(data.aws_subnets.private.ids, 1)
  security_groups = [data.aws_security_group.ssh.id, module.sg-boundary-worker-egress.security_group_id]

  lifecycle {
    ignore_changes = all
  }
  
  tags = {
    Name  = "${var.deployment_id}-boundary-worker-egress"
  }
}

resource "null_resource" "worker-egress" {
  connection {
    host          = aws_instance.worker-egress.private_dns
    user          = "ubuntu"
    agent         = false
    private_key   = local.key_pair_private_key
    bastion_host  = var.bastion_public_fqdn
  }

  provisioner "file" {
    source      = "${path.module}/configs/worker-egress.hcl"
    destination = "/var/tmp/worker-egress-config.hcl"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /var/tmp/worker-egress-config.hcl /opt/boundary/config/boundary-worker.hcl",
      "sudo /opt/boundary/bin/run-boundary worker"
    ]
  }

  depends_on = [ 
    local_file.worker-egress-config 
  ]
}