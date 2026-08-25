data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.deployment_id}*"]
  }
}

module "sg-boundary-worker-egress" {
  source = "terraform-aws-modules/security-group/aws"
  version     = "4.9.0"

  name        = "${var.deployment_id}-boundary-worker-egress"
  vpc_id      = data.aws_vpc.this.id

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