variable "visibility" {
  description = "Repository visibility: must be either 'public' or 'internal'."
  type        = string
  default     = "internal"

  validation {
    condition     = contains(["public", "internal"], var.visibility)
    error_message = "Visibility must be either 'public' or 'internal'."
  }
}

variable "name" {
  description = "The name of the repository. Must not contain spaces."
  type        = string

  validation {
    condition     = !can(regex(" ", var.name))
    error_message = "Repository name must not contain spaces."
  }
}

variable "description" {
  description = "The description of the repository."
  type        = string
  default     = ""
}

variable "repository_type" {
  description = "The type of repository. Allowed values: 'iac', 'application', 'lz', 'none'."
  type        = string
  default     = "none"

  validation {
    condition     = contains(["iac", "application", "lz", "none"], var.repository_type)
    error_message = "repository_type must be one of: 'iac', 'application', 'lz', or 'none'."
  }
}

variable "has_wiki" {
  type    = bool
  default = false
}

variable "has_downloads" {
  type    = bool
  default = false
}