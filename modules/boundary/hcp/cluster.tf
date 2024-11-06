resource "hcp_boundary_cluster" "this" {
  cluster_id = var.deployment_id
  tier       = var.tier
  username   = var.init_user
  password   = var.init_pass
  maintenance_window_config {
    day          = "SATURDAY"
    start        = 2
    end          = 8
    upgrade_type = "SCHEDULED"
  }
}