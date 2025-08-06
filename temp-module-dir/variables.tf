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

variable "create_environments" {
  description = "Whether to create repository environments"
  type        = bool
  default     = true
}

variable "codeowners" {
  description = "List of GitHub teams used as reviewers"
  type        = list(string)
}

variable "environments" {
  description = "List of environment configurations"
  type = list(object({
    name                                   = string
    can_admins_bypass                      = bool
    prevent_self_review                    = bool
    deployment_branch_policy_protected     = bool
    deployment_branch_policy_custom_branch = bool
  }))

  default = [
    {
      name                                   = "dev"
      can_admins_bypass                      = true
      prevent_self_review                    = true
      deployment_branch_policy_protected     = false
      deployment_branch_policy_custom_branch = false
    },
    {
      name                                   = "qat"
      can_admins_bypass                      = false
      prevent_self_review                    = true
      deployment_branch_policy_protected     = true
      deployment_branch_policy_custom_branch = true
    },
    {
      name                                   = "pre"
      can_admins_bypass                      = false
      prevent_self_review                    = true
      deployment_branch_policy_protected     = true
      deployment_branch_policy_custom_branch = true
    },
    {
      name                                   = "prd"
      can_admins_bypass                      = false
      prevent_self_review                    = true
      deployment_branch_policy_protected     = true
      deployment_branch_policy_custom_branch = true
    }
  ]
}

variable "create_secrets" {
  description = "Which cloud secrets to create. Options: 'aws', 'azure', or 'none'."
  type        = string
  default     = "none"

  validation {
    condition     = contains(["aws", "azure", "none"], var.create_secrets)
    error_message = "create_secrets must be 'aws', 'azure', or 'none'."
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

variable "github_user_node_id" {
  type = string
}

# GitHub environment secrets:
variable "aws_account_id" {
  type    = string
  default = ""
}
variable "aws_role_name" {
  type    = string
  default = ""
}
variable "azure_client_id" {
  type    = string
  default = ""
}
variable "azure_tenant_id" {
  type    = string
  default = ""
}
variable "azure_subscription_id" {
  type    = string
  default = ""
}
variable "azure_resource_group_name" {
  type    = string
  default = ""
}