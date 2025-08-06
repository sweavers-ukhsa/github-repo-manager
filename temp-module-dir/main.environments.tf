# Optional resources, based on create_environments being set to true. Default is true.
resource "github_repository_environment" "environments" {
  for_each = var.create_environments ? {
    for env in var.environments : env.name => env
  } : {}

  environment         = each.key
  repository          = github_repository.this.name
  wait_timer          = 0
  prevent_self_review = each.value.prevent_self_review
  can_admins_bypass   = each.value.can_admins_bypass

  reviewers {
    # teams = var.codeowners
    users = var.codeowners
  }

  deployment_branch_policy {
    protected_branches     = each.value.deployment_branch_policy_protected
    custom_branch_policies = each.value.deployment_branch_policy_custom_branch
  }
}

resource "github_actions_environment_secret" "secrets" {
  for_each = local.secret_map

  repository      = github_repository.this.name
  environment     = each.value.environment
  secret_name     = each.value.secret_name
  plaintext_value = each.value.secret_value
}

# resource "github_repository_environment_deployment_policy" "deployment_policies" {
#   repository     = github_repository.this.name
#   environment    = each.value.environment
#   branch_pattern = each.value.branc_pattern
# }