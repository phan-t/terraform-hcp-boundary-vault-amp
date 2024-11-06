output "vpc_id" {
  description = "vpc id"
  value       = module.vpc.vpc_id
}

output "bastion_public_fqdn" {
  description = "public fqdn of bastion"
  value       = aws_instance.bastion.public_dns
}