module "repo" {
  source              = "./temp-module-dir"
  name                = var.name
  description         = var.description
  visibility          = var.visibility
  has_wiki            = var.has_wiki
  has_downloads       = var.has_downloads
  repository_type     = var.repository_type
  codeowners          = [data.github_user.this.id]
  github_user_node_id = data.github_user.this.node_id
}