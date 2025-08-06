locals {
  # 1. Build a map of secrets from var inputs (empty if create_secrets is "none")
  environment_secrets = var.create_secrets == "aws" ? {
    AWS_ACCOUNT_ID = var.aws_account_id
    AWS_ROLE_NAME  = var.aws_role_name
    } : var.create_secrets == "azure" ? {
    AZURE_CLIENT_ID           = var.azure_client_id
    AZURE_TENANT_ID           = var.azure_tenant_id
    AZURE_SUBSCRIPTION_ID     = var.azure_subscription_id
    AZURE_RESOURCE_GROUP_NAME = var.azure_resource_group_name
  } : {}

  # 2. Loop through the environments and flatten the list of objects for each env and it's secrets
  secret_list = flatten([
    for env in var.environments : [
      for secret_name, secret_value in local.environment_secrets : {
        key          = "${env.name}-${secret_name}"
        environment  = env.name
        secret_name  = secret_name
        secret_value = secret_value
      }
    ]
  ])

  # 3. Re-map flattened list back to unique key > secrets
  secret_map = {
    for item in local.secret_list :
    item.key => {
      environment  = item.environment
      secret_name  = item.secret_name
      secret_value = item.secret_value
    }
  }
}