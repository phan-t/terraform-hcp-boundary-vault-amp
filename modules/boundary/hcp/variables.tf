variable "deployment_id" {
  description = "deployment id"
  type        = string
}

variable "tier" {
  description = "boundary cluster tier"
  type        = string
}

variable "init_user" {
  description = "initial admin username"
  type        = string
}

variable "init_pass" {
  description = "initial admin password"
  type        = string
}