data "vault_namespace" "platform_namespace" {
  path = var.platform_namespace
}

resource "vault_namespace" "tenant" {
  for_each  = var.tenant_namespaces
  
  namespace = data.vault_namespace.platform_namespace.path
  path      = each.key
}