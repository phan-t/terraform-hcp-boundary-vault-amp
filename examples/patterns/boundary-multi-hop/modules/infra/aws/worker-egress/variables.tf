variable "deployment_id" {
  description = "deployment id"
  type        = string
}

variable "bastion_public_fqdn" {
  description = "public fqdn of bastion host"
  type        =  string 
}

variable "hcp_boundary_cluster_id" {
  description = "hcp boundary cluster id"
  type        = string
}

variable "upstream_worker_private_ip" {
  description = "private ip of boundary worker ingress"
  type        = string
}