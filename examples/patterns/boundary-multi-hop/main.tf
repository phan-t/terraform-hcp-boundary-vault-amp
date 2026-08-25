data "terraform_remote_state" "tcm" {
  backend = "local"

  config = {
    path = "../../../terraform.tfstate"
  }
}

locals {
  hcp_boundary_cluster_id = regex("[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", data.terraform_remote_state.tcm.outputs.hcp_boundary_cluster_public_fqdn)
}

module "worker-ingress-aws" {
  source = "./modules/infra/aws/worker-ingress"

  deployment_id           = data.terraform_remote_state.tcm.outputs.deployment_id
  hcp_boundary_cluster_id = local.hcp_boundary_cluster_id
}

module "boundary" {
  source = "./modules/boundary"

  deployment_id = data.terraform_remote_state.tcm.outputs.deployment_id
}

module "target-bastion" {
  source = "./modules/targets/bastion"

  deployment_id     = data.terraform_remote_state.tcm.outputs.deployment_id
  boundary_scope_id = module.boundary.scope_platform_team_test_id
}

module "worker-egress-aws" {
  source = "./modules/infra/aws/worker-egress"

  deployment_id              = data.terraform_remote_state.tcm.outputs.deployment_id
  bastion_public_fqdn        = data.terraform_remote_state.tcm.outputs.aws_bastion_public_fqdn
  hcp_boundary_cluster_id    = local.hcp_boundary_cluster_id
  upstream_worker_private_ip = module.worker-ingress-aws.private_ip
}

module "target-http-web" {
  source = "./modules/targets/http-web"

  deployment_id       = data.terraform_remote_state.tcm.outputs.deployment_id
  bastion_public_fqdn = data.terraform_remote_state.tcm.outputs.aws_bastion_public_fqdn
  boundary_scope_id   = module.boundary.scope_platform_team_test_id
}