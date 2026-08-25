resource "vault_namespace" "platform" {
  for_each  = var.platform_namespaces
  
  path      = each.key
}