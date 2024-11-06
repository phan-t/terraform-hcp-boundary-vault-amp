disable_mlock = true

listener "tcp" {
  address = "0.0.0.0:9202"
  purpose = "proxy"
}

worker {
  public_addr = "${private_ip}"
  initial_upstreams = ["${upstream_worker_private_ip}:9202"]
  auth_storage_path = "/opt/boundary/auth-storage"
  controller_generated_activation_token = "${token}"
  tags {
    type = ["egress", "downstream", "worker2"]
  }
}