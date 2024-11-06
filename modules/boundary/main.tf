// hcp boundary

module "boundary-hcp" {
  source = "./hcp"

  deployment_id = var.deployment_id
  tier          = "plus"
  init_user     = var.init_user
  init_pass     = var.init_pass
}
