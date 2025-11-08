data "github_repository_file" "exists" {
  for_each = local.active_files_settings

  repository = github_repository.active[each.value.repository].name
  branch     = each.value.autocreate_branch_source_branch
  file       = each.value.file
}

resource "github_repository_file" "to_create" {
  for_each = local.not_existing_files

  repository = github_repository.active[each.value.repository].name
  file       = each.value.file
  content    = file("../../${each.value.file}")
  branch     = each.value.branch

  overwrite_on_create             = each.value.overwrite_on_create
  autocreate_branch               = each.value.autocreate_branch
  autocreate_branch_source_branch = each.value.autocreate_branch_source_branch
}

resource "github_repository_pull_request" "to_create" {
  for_each = local.not_existing_files_repos

  base_repository = each.value.base_repository
  base_ref        = each.value.base_ref
  head_ref        = each.value.head_ref
  title           = "chore(github-actions): sync"

  depends_on = [
    github_repository_file.to_create
  ]
}

resource "github_branch" "to_create" {
  for_each = local.not_existing_files_repos

  repository = each.value.base_repository
  branch     = each.value.head_ref

  depends_on = [
    github_repository_pull_request.to_create
  ]
}

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
