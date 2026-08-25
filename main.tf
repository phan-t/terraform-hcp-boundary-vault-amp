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

module "vault-hcp" {
  source = "./modules/vault"

  deployment_id = local.deployment_id
  hvn_id        = module.hcp-hvn.id

  depends_on = [ 
    module.infra-aws 
]
}

// hashicorp cloud platform (hcp) infrastructure

module "hcp-hvn" {
  source = "./modules/infra/hcp"

  region                     = var.aws_region
  deployment_id              = local.deployment_id
  cidr                       = var.hcp_hvn_cidr
  aws_vpc_cidr               = var.aws_vpc_cidr
  aws_tgw_id                 = module.infra-aws.tgw_id
  aws_ram_resource_share_arn = module.infra-aws.ram_resource_share_arn
}

// amazon web services (aws) infrastructure

module "infra-aws" {
  source  = "./modules/infra/aws"
  
  deployment_id               = local.deployment_id
  vpc_cidr                    = var.aws_vpc_cidr
  hcp_hvn_provider_account_id = module.hcp-hvn.provider_account_id
  hcp_hvn_cidr                = var.hcp_hvn_cidr
}