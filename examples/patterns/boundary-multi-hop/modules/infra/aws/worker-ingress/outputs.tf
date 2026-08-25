output "public_fqdn" {
  description = "public fqdn of boundary worker ingress"
  value       = aws_instance.worker-ingress.public_dns
}

output "private_ip" {
  description = "private ip of boundary worker ingress"
  value       = aws_instance.worker-ingress.private_ip
}