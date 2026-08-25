resource "boundary_worker" "egress" {
  scope_id    = "global"
  name        = "worker-egress"
  description = "self managed worker with controller led auth"
}