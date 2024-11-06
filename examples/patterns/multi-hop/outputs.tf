output "aws_boundary_worker_ingress_public_fqdn" {
  description = "public fqdn of aws boundary worker ingress"
  value       = module.worker-ingress-aws.public_fqdn
}