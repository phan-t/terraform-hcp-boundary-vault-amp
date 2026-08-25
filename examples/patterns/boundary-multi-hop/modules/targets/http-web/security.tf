data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.deployment_id}*"]
  }
}

module "sg-http-web" {
  source = "terraform-aws-modules/security-group/aws"
  version     = "4.9.0"

  name        = "${var.deployment_id}-http-web"
  vpc_id      = data.aws_vpc.this.id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http-web-tcp"
      cidr_blocks = "10.200.0.0/16"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "any-any"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}