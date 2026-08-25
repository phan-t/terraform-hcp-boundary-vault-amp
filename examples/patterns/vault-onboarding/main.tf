data "terraform_remote_state" "tcm" {
  backend = "local"

  config = {
    path = "../../../terraform.tfstate"
  }
}

module "platform" {
  source = "./modules/platform"  
  
  platform_namespaces = [
    "cloud-2",
    "cloud-x", 
    ]
}   

module "tenant" {
  source = "./modules/tenant"  
  
  platform_namespace = "cloud-2"
  tenant_namespaces = [
    "bank",
    "digital",
    ]

depends_on = [ 
    module.platform 
    ]
}
