// generic variables

variable "deployment_name" {
  description = "deployment name to prefix resources"
  type        = string
  default     = "sandpit"
}

// hashicorp cloud platform (hcp) variables

variable "hcp_client_id" {
  description = "hcp client id"
  type        = string
  default     = ""
}

variable "hcp_client_secret" {
  description = "hcp client secret"
  type        = string
  default     = ""
}

// amazon web services (aws) variables

variable "aws_region" {
  description = "aws region"
  type        = string
  default     = ""
}

variable "aws_vpc_cidr" {
  description = "aws vpc cidr"
  type        = string
  default     = "10.200.0.0/16"
}

// hashicorp boundary variables

variable "boundary_init_user" {
  description = "initial username"
  type        = string
  default     = "admin"
}

variable "boundary_init_pass" {
  description = "initial password"
  type        = string
  sensitive   = true
}