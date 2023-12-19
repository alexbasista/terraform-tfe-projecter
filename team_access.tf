data "tfe_team" "managed" {
  for_each = var.team_access

  name         = each.key
  organization = var.organization
}

resource "tfe_team_project_access" "managed" {
  for_each = var.team_access

  project_id = tfe_project.project.id
  team_id    = [for t in [data.tfe_team.managed[each.key]] : t.id if t.name == each.key][0]
  access     = each.value
}

data "tfe_team" "custom" {
  for_each = var.custom_team_access

  name         = each.key
  organization = var.organization
}

resource "tfe_team_project_access" "custom" {
  for_each = var.custom_team_access

  project_id = tfe_project.project.id
  team_id    = [for t in [data.tfe_team.custom[each.key]] : t.id if t.name == each.key][0]
  access     = "custom"

  project_access {
    settings = lookup(each.value.project_access, "settings", "read")
    teams    = lookup(each.value.project_access, "teams", "none")
  }

  workspace_access {
    create         = lookup(each.value.workspace_access, "create", false)
    delete         = lookup(each.value.workspace_access, "delete", false)
    move           = lookup(each.value.workspace_access, "move", false)
    runs           = lookup(each.value.workspace_access, "runs", "read")
    variables      = lookup(each.value.workspace_access, "variables", "none")
    state_versions = lookup(each.value.workspace_access, "state_versions", "none")
    sentinel_mocks = lookup(each.value.workspace_access, "sentinel_mocks", "none")
    run_tasks      = lookup(each.value.workspace_access, "run_tasks", false)
    locking        = lookup(each.value.workspace_access, "locking", false)
  }
}