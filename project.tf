resource "tfe_project" "project" {
  name         = var.project_name
  organization = var.organization
  description  = var.description
  tag_names    = var.tag_names
}