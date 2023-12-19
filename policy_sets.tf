data "tfe_policy_set" "ps" {
  for_each = toset(var.policy_set_names)

  name         = each.value
  organization = var.organization
}

resource "tfe_project_policy_set" "ps" {
  for_each = data.tfe_policy_set.ps

  policy_set_id = each.value.id
  project_id    = tfe_project.project.id
}