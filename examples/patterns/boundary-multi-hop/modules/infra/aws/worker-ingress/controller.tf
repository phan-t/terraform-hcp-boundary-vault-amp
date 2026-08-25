resource "boundary_worker" "ingress" {
  scope_id    = "global"
  name        = "worker-ingress"
  description = "self managed worker with controller led auth"
}