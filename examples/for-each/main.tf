module "projects" {
  for_each = var.projects
  source   = "alexbasista/projecter/tfe"
  version  = "0.1.1"

  organization = var.organization
  project_name = each.key
  description  = each.value.description
  tag_names    = each.value.tag_names

  team_access        = each.value.team_access
  custom_team_access = each.value.custom_team_access
  variable_set_names = each.value.variable_set_names
  policy_set_names   = each.value.policy_set_names
}