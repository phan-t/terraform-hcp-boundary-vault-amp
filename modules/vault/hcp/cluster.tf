resource "hcp_vault_cluster" "this" {
  hvn_id            = var.hvn_id
  cluster_id        = var.deployment_id
  tier              = var.tier
  public_endpoint   = true
}

resource "hcp_vault_cluster_admin_token" "this" {
  cluster_id = hcp_vault_cluster.this.cluster_id
}