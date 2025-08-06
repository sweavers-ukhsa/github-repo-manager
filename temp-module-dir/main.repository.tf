resource "github_repository" "this" {
  name        = var.name
  description = "${var.description}: Managed by github-repo-manager"
  visibility  = var.visibility

  allow_merge_commit     = false
  allow_auto_merge       = false
  allow_squash_merge     = true
  allow_rebase_merge     = true
  archived               = true
  delete_branch_on_merge = true
  has_issues             = true
  has_projects           = false
  has_wiki               = var.has_wiki
  has_downloads          = var.has_downloads
  is_template            = false

  dynamic "template" {
    for_each = var.repository_type == "iac" ? [1] : []
    content {
      owner                = "ukhsa-collaboration"
      repository           = "devops-terraform-template"
      include_all_branches = false
    }
  }
}

resource "github_branch_default" "main" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_branch_protection" "main" {
  repository_id = github_repository.this.node_id

  pattern = "main"

  restrict_pushes {
    push_allowances = [
      var.github_user_node_id,
    ]
  }
}