terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "~> 4.5.0"
    }
  }
}

provider "vault" {
  address   = data.terraform_remote_state.tcm.outputs.hcp_vault_public_endpoint_fqdn
  token     = data.terraform_remote_state.tcm.outputs.hcp_vault_token_admin
  namespace = "admin"
}