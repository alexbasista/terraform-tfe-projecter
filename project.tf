resource "tfe_project" "project" {
  name         = var.project_name
  organization = var.organization
  description  = var.description
  tags         = var.tags
}