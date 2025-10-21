#------------------------------------------------------------------------------
# Project Outputs
#------------------------------------------------------------------------------
output "project_id" {
  description = "ID of the project"
  value       = tfe_project.project.id
}

output "project_name" {
  description = "Name of the project"
  value       = tfe_project.project.name
}

output "organization" {
  description = "Organization that the project belongs to"
  value       = tfe_project.project.organization
}

output "description" {
  description = "Description of the project"
  value       = tfe_project.project.description
}

output "tags" {
  description = "Tags applied to the project"
  value       = tfe_project.project.tags
}

#------------------------------------------------------------------------------
# Team Access Outputs
#------------------------------------------------------------------------------
output "team_access_ids" {
  description = "Map of team names to their project access resource IDs (fixed permissions)"
  value       = { for k, v in tfe_team_project_access.managed : k => v.id }
}

output "custom_team_access_ids" {
  description = "Map of team names to their project access resource IDs (custom permissions)."
  value       = { for k, v in tfe_team_project_access.custom : k => v.id }
}

#------------------------------------------------------------------------------
# Variable Set Outputs
#------------------------------------------------------------------------------
output "variable_set_ids" {
  description = "Map of variable set names to their IDs applied to the project"
  value       = { for k, v in data.tfe_variable_set.vs : k => v.id }
}

output "project_variable_set_ids" {
  description = "Map of variable set names to their project variable set resource IDs"
  value       = { for k, v in tfe_project_variable_set.vs : k => v.id }
}

#------------------------------------------------------------------------------
# Policy Set Outputs
#------------------------------------------------------------------------------
output "policy_set_ids" {
  description = "Map of policy set names to their IDs enforced on the project"
  value       = { for k, v in data.tfe_policy_set.ps : k => v.id }
}

output "project_policy_set_ids" {
  description = "Map of policy set names to their project policy set resource IDs"
  value       = { for k, v in tfe_project_policy_set.ps : k => v.id }
}
