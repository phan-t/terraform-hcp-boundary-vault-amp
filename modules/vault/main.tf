// hcp vault

module "vault-hcp" {
  source = "./hcp"

  deployment_id   = var.deployment_id
  hvn_id          = var.hvn_id
  tier            = "dev"
}