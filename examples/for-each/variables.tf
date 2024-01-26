variable "projects" {
  type = map(
    object({
      team_access = optional(map(string), {})
      custom_team_access = optional(map(object({
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
      })), {})
      variable_set_names = optional(list(string), [])
      policy_set_names   = optional(list(string), [])
    })
  )
  description = "Custom map of objects that defines Projects configuration."
}

variable "organization" {
  type        = string
  description = "Name of Organization to create Projects in."
}