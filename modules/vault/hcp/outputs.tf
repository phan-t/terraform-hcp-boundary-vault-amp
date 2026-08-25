output "token_admin" {
  value     = hcp_vault_cluster_admin_token.this.token
  sensitive = true
}

output "public_endpoint_fqdn" {
  value = hcp_vault_cluster.this.vault_public_endpoint_url
}

output "private_endpoint_fqdn" {
  value = hcp_vault_cluster.this.vault_private_endpoint_url
}