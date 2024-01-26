module "projects" {
  for_each = var.projects
  source   = "../.."

  organization = var.organization
  project_name = each.key

  team_access        = each.value.team_access
  custom_team_access = each.value.custom_team_access
  variable_set_names = each.value.variable_set_names
  policy_set_names   = each.value.policy_set_names
}