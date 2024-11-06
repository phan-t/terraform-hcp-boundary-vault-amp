disable_mlock = true

listener "tcp" {
  address = "0.0.0.0:9202"
  purpose = "proxy"
}

worker {
  public_addr = "10.200.1.151"
  initial_upstreams = ["10.200.5.128:9202"]
  auth_storage_path = "/opt/boundary/auth-storage"
  controller_generated_activation_token = ""
  tags {
    type = ["egress", "downstream", "worker2"]
  }
}