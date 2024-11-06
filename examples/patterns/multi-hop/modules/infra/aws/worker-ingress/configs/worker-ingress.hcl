disable_mlock = true

hcp_boundary_cluster_id = "1abef773-8d06-42f2-86e5-6562900841e9"

listener "tcp" {
  address = "0.0.0.0:9202"
  purpose = "proxy"
}

worker {
  public_addr = "3.106.193.18"
  auth_storage_path = "/opt/boundary/auth-storage"
  controller_generated_activation_token = ""
  tags {
    type = ["ingress", "upstream", "worker1"]
  }
}