variable "RENOVATE_APP_ID" {
  type = string
}
resource "github_actions_secret" "RENOVATE_APP_ID" {
  for_each = local.active_repos_settings

  repository      = github_repository.active[each.key].name
  secret_name     = "RENOVATE_APP_ID"
  plaintext_value = sensitive(var.RENOVATE_APP_ID)
}

variable "RENOVATE_PRIVATE_KEY" {
  type = string
}
resource "github_actions_secret" "RENOVATE_PRIVATE_KEY" {
  for_each = local.active_repos_settings

  repository      = github_repository.active[each.key].name
  secret_name     = "RENOVATE_PRIVATE_KEY"
  plaintext_value = sensitive(var.RENOVATE_PRIVATE_KEY)
}
