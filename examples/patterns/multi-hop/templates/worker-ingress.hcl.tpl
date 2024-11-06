disable_mlock = true

hcp_boundary_cluster_id = "${hcp_boundary_cluster_id}"

listener "tcp" {
  address = "0.0.0.0:9202"
  purpose = "proxy"
}

worker {
  public_addr = "${public_ip}"
  auth_storage_path = "/opt/boundary/auth-storage"
  controller_generated_activation_token = "${token}"
  tags {
    type = ["ingress", "upstream", "worker1"]
  }
}