module "projecter" {
  source = "../.."
  
  organization = var.organization
  project_name = var.project_name
  description  = var.description
  tags         = var.tags
}
