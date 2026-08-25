resource "vault_mount" "kvv2" {
  for_each  =  vault_namespace.tenant

  namespace   = each.value.path_fq
  path        = "kv"
  type        = "kv-v2"

  options = {
    version = "2"
    type    = "kv-v2"
  }
}