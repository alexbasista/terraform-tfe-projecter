#------------------------------------------------------------------------------
# Project
#------------------------------------------------------------------------------
variable "organization" {
  type        = string
  description = "Name of Organization to create Project in."
}

variable "project_name" {
  type        = string
  description = "Name of Project."

  validation {
    condition     = length(var.project_name) >= 3 && length(var.project_name) <= 36
    error_message = "Project name must be between 3 and 36 characters in length."
  }
}

#------------------------------------------------------------------------------
# Project Team Access
#------------------------------------------------------------------------------
variable "team_access" {
  type        = map(string)
  description = "Map of existing Team(s) and built-in permissions to grant on Project."
  default     = {}
}

variable "custom_team_access" {
  type = map(
    object({
      project_access = object({
        settings = string
        teams    = string
      })
      workspace_access = object({
        create         = bool
        delete         = bool
        move           = bool
        runs           = string
        variables      = string
        state_versions = string
        sentinel_mocks = string
        run_tasks      = bool
        locking        = bool
      })
    })
  )
  description = "Map of existing Team(s) and custom permissions to grant on Project. If used, all keys in the object must be specified."
  default     = {}
}

#------------------------------------------------------------------------------
# Project Variable Sets
#------------------------------------------------------------------------------
variable "variable_set_names" {
  type        = list(string)
  description = "List of names of existing Variable Set(s) to apply to Project. Variable Set(s) cannot be global."
  default     = []
}

#------------------------------------------------------------------------------
# Project Policy Sets
#------------------------------------------------------------------------------
variable "policy_set_names" {
  type        = list(string)
  description = "List of names of existing Policy Set(s) to enforce on Project. Policy Set(s) cannot be global."
  default     = []
}