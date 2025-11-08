resource "github_repository" "active" {
  for_each = local.active_repos_settings

  name         = each.key
  description  = each.value.description
  homepage_url = each.value.homepage_url
  visibility   = each.value.visibility

  has_issues      = each.value.has_issues
  has_discussions = each.value.has_discussions
  has_projects    = each.value.has_projects
  has_wiki        = each.value.has_wiki
  is_template     = each.value.is_template

  allow_merge_commit          = each.value.allow_merge_commit
  allow_squash_merge          = each.value.allow_squash_merge
  allow_rebase_merge          = each.value.allow_rebase_merge
  allow_auto_merge            = each.value.allow_auto_merge
  delete_branch_on_merge      = each.value.delete_branch_on_merge
  web_commit_signoff_required = each.value.web_commit_signoff_required

  auto_init = each.value.auto_init

  archived           = each.value.archived
  archive_on_destroy = each.value.archive_on_destroy

  security_and_analysis {
    dynamic "advanced_security" {
      for_each = each.value.security_and_analysis.advanced_security.status == "enabled" ? [1] : []
      content {
        status = each.value.security_and_analysis.advanced_security.status
      }
    }
    dynamic "secret_scanning" {
      for_each = each.value.security_and_analysis.secret_scanning.status == "enabled" ? [1] : []
      content {
        status = each.value.security_and_analysis.secret_scanning.status
      }
    }
    dynamic "secret_scanning_push_protection" {
      for_each = each.value.security_and_analysis.secret_scanning_push_protection.status == "enabled" ? [1] : []
      content {
        status = each.value.security_and_analysis.secret_scanning_push_protection.status
      }
    }
  }

  allow_update_branch = each.value.allow_update_branch

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      has_downloads,
      merge_commit_message,
      merge_commit_title,
      squash_merge_commit_message,
      squash_merge_commit_title,
    ]
  }
}

resource "github_actions_repository_permissions" "active" {
  for_each = local.active_repos_settings

  repository      = github_repository.active[each.key].name
  allowed_actions = each.value.actions.allowed_actions
  enabled         = each.value.actions.enabled
  allowed_actions_config {
    github_owned_allowed = each.value.actions.allowed_actions_config.github_owned_allowed
    patterns_allowed     = each.value.actions.allowed_actions_config.patterns_allowed
    verified_allowed     = each.value.actions.allowed_actions_config.verified_allowed
  }
}

resource "github_branch_default" "active" {
  for_each = local.active_repos_settings

  repository = github_repository.active[each.key].name
  branch     = each.value.branch_default
}

resource "github_issue_label" "active" {
  for_each = local.active_labelsrepos_settings

  repository = github_repository.active[each.value.repository].name
  name       = each.value.label
  color      = each.value.color
}

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
