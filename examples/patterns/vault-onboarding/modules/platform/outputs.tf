output "namespace_paths" {
  value = values(vault_namespace.platform).*.path
}