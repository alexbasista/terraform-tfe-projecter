data "tfe_variable_set" "vs" {
  for_each = var.variable_set_names == null ? [] : toset(var.variable_set_names)

  name         = each.value
  organization = var.organization
}

resource "tfe_project_variable_set" "vs" {
  for_each = data.tfe_variable_set.vs

  variable_set_id = each.value.id
  project_id      = tfe_project.project.id
}