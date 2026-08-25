output "token_admin" {
  value     = module.vault-hcp.token_admin
  sensitive = true
}

output "public_endpoint_fqdn" {
  value = module.vault-hcp.public_endpoint_fqdn
}

output "private_endpoint_fqdn" {
  value = module.vault-hcp.private_endpoint_fqdn
}