output "cluster_public_fqdn" {
  description = "hcp boundary cluster public fqdn"
  value       = hcp_boundary_cluster.this.cluster_url
}