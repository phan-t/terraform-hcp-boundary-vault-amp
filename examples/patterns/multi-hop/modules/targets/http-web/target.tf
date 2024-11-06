data "aws_instance" "http-web" {
  filter {
    name   = "tag:Name"
    values = ["${var.deployment_id}-http-web"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  depends_on = [ 
    aws_instance.http-web
  ]
}

resource "boundary_target" "http-web" {
  name                  = "http-web"
  description           = "http-web host"
  type                  = "tcp"
  default_port          = "80"
  scope_id              = var.boundary_scope_id
  address               = data.aws_instance.http-web.private_ip
  ingress_worker_filter = "\"ingress\" in \"/tags/type\""
  egress_worker_filter  = "\"egress\" in \"/tags/type\""
}