variable "organization" {
  type        = string
  description = "Name of Organization to create Project in."
}

variable "project_name" {
  type        = string
  description = "Name of Project."
}

variable "description" {
  type        = string
  description = "Description of Project."
  default     = null
}

variable "tag_names" {
  type        = list(string)
  description = "List of tag names to apply to Project."
  default     = []
}

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

variable "variable_set_names" {
  type        = list(string)
  description = "List of names of existing Variable Sets to apply to Project."
  default     = []
}

variable "policy_set_names" {
  type        = list(string)
  description = "List of names of existing Policy Sets to enforce on Project."
  default     = []
}