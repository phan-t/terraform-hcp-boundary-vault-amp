data "aws_instance" "bastion" {
  filter {
    name   = "tag:Name"
    values = ["${var.deployment_id}-bastion"]
  }
}

resource "boundary_target" "bastion" {
  name                  = "bastion"
  description           = "bastion host"
  type                  = "tcp"
  default_port          = "22"
  scope_id              = var.boundary_scope_id
  address               = data.aws_instance.bastion.private_ip
  ingress_worker_filter = "\"ingress\" in \"/tags/type\""
}