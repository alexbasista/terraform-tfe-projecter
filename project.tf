resource "tfe_project" "project" {
  name         = var.project_name
  organization = var.organization
}