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
