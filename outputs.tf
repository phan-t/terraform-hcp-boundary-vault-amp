// generic outputs

output "deployment_id" {
  description = "deployment identifier"
  value       = local.deployment_id
}

// amazon web services (aws) outputs

output "aws_region" {
  description = "aws region"
  value       = var.aws_region
}

output "aws_bastion_public_fqdn" {
  description = "aws public fqdn of bastion node"
  value       = module.infra-aws.bastion_public_fqdn
}

// hashicorp cloud platform (hcp) outputs

output "hcp_boundary_cluster_public_fqdn" {
  description = "hcp boundary cluster public fqdn"
  value       = module.boundary-hcp.cluster_public_fqdn
}

// hashicorp boundary outputs

output "hcp_boundary_inital_user" {
  description = "hcp boundary initial user"
  value       = var.boundary_init_user 
}

output "hcp_boundary_inital_pass" {
  description = "hcp boundary initial password"
  value       = var.boundary_init_pass
  sensitive   = true
}