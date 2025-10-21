module "projecter" {
  source = "../.."

  organization = var.organization
  project_name = var.project_name

  team_access        = var.team_access
  custom_team_access = var.custom_team_access
  variable_set_names = var.variable_set_names
  policy_set_names   = var.policy_set_names
}