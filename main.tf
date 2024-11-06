locals {
  deployment_id = lower("${var.deployment_name}-${random_string.suffix.result}")
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "boundary-hcp" {
  source = "./modules/boundary"

  deployment_id = local.deployment_id
  init_user     = var.boundary_init_user
  init_pass     = var.boundary_init_pass

  depends_on = [ 
    module.infra-aws 
]
}

// amazon web services (aws) infrastructure

module "infra-aws" {
  source  = "./modules/infra/aws"
  
  deployment_id = local.deployment_id
  vpc_cidr      = var.aws_vpc_cidr
}