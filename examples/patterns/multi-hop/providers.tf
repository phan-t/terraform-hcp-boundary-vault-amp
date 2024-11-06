terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
    boundary = {
      source = "hashicorp/boundary"
      version = "~> 1.2.0"
    }
  }
}

provider "aws" {
  region = data.terraform_remote_state.tcm.outputs.aws_region
}

provider "boundary" {
  addr                   = data.terraform_remote_state.tcm.outputs.hcp_boundary_cluster_public_fqdn
  auth_method_login_name = data.terraform_remote_state.tcm.outputs.hcp_boundary_inital_user
  auth_method_password   = data.terraform_remote_state.tcm.outputs.hcp_boundary_inital_pass
}