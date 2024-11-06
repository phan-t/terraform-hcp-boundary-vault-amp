resource "boundary_scope" "global" {
  global_scope = true
  scope_id     = "global"
}

resource "boundary_scope" "platform-team" {
  name                     = "platform-team"
  description              = "platform team organisation"
  scope_id                 = boundary_scope.global.id
  auto_create_admin_role   = true
}

resource "boundary_scope" "platform-team-test" {
  name                   = "test"
  description            = "test project"
  scope_id               = boundary_scope.platform-team.id
  auto_create_admin_role = true
}