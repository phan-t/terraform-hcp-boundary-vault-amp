output "cluster_public_fqdn" {
  description = "hcp boundary cluster public fqdn"
  value       = module.boundary-hcp.cluster_public_fqdn
}