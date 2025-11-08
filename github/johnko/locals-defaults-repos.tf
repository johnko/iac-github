locals {
  default_repo_settings = {

    # for resource github_repository
    # name = ""
    description  = null
    homepage_url = null
    visibility   = "private"

    has_issues      = false
    has_discussions = false
    has_projects    = false
    has_wiki        = false
    is_template     = false

    allow_merge_commit          = false
    allow_squash_merge          = true
    allow_rebase_merge          = true
    allow_auto_merge            = false
    delete_branch_on_merge      = true
    web_commit_signoff_required = false

    auto_init = false

    archived           = false
    archive_on_destroy = true
    security_and_analysis = {
      advanced_security = {
        status = "disabled" # disabled on personal plan
      }
      secret_scanning = {
        status = "enabled"
      }
      secret_scanning_push_protection = {
        status = "enabled"
      }
    }
    allow_update_branch = true

    # for resource github_actions_repository_permissions
    actions = {
      enabled         = false
      allowed_actions = "selected"
      allowed_actions_config = {
        github_owned_allowed = true
        patterns_allowed = [
          "hashicorp/setup-terraform@*",
          "johnko/*",
          "opentofu/setup-opentofu@*",
          "renovatebot/github-action@*",
        ]
        verified_allowed = false
      }
    }

    # for resource github_branch_default
    branch_default = "main"
  }

  # for resource github_repository
  all_repos_settings = { for k, v in local.repos :
    k => merge(
      local.default_repo_settings,
      v,
      contains(keys(v), "security_and_analysis")
      ? { "security_and_analysis" : merge(
        local.default_repo_settings.security_and_analysis,
        v.security_and_analysis
      ) }
      : { "security_and_analysis" : local.default_repo_settings.security_and_analysis },
      contains(keys(v), "actions")
      ? { "actions" : merge(
        local.default_repo_settings.actions,
        v.actions
      ) }
      : { "actions" : local.default_repo_settings.actions }
  ) }
  active_repos_settings = { for k, v in local.all_repos_settings : k => v
    if v.archived == false
  }
  archived_repos_settings = { for k, v in local.all_repos_settings : k => v
    if v.archived == true
  }

}

# output "all_repos_settings" {
#   value = local.all_repos_settings
# }
# output "active_repos_settings" {
#   value = local.active_repos_settings
# }
# output "archived_repos_settings" {
#   value = local.archived_repos_settings
# }
