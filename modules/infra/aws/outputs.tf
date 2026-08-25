output "vpc_id" {
  description = "vpc id"
  value       = module.vpc.vpc_id
}

output "bastion_public_fqdn" {
  description = "public fqdn of bastion"
  value       = aws_instance.bastion.public_dns
}

output "tgw_id"{
  value = module.tgw.ec2_transit_gateway_id
}

output "ram_resource_share_arn" {
  value = module.tgw.ram_resource_share_id
}