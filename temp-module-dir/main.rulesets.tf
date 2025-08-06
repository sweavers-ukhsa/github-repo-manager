# resource "github_repository_ruleset" "this" {
#   name        = "main-ruleset"
#   repository  = github_repository.this.name
#   target      = "branch"
#   enforcement = "active"

#   conditions {
#     ref_name {
#       include = ["~ALL"]
#       exclude = []
#     }
#   }

#   bypass_actors {
#     actor_id    = 13473
#     actor_type  = "Integration"
#     bypass_mode = "always"
#   }

#   rules {
#     creation                = true
#     update                  = true
#     deletion                = true
#     required_linear_history = true
#     required_signatures     = true

#     required_deployments {
#       required_deployment_environments = ["test"]
#     }
#   }
# }