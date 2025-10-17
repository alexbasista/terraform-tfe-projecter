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