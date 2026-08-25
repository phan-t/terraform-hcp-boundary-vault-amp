variable "platform_namespace" {
  type = string
}

variable "tenant_namespaces" {
  type = set(string)
  default = []
}