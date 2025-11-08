locals {
  default_repo_settings = {
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
  }

  green  = "0e8a16" #0e8a16
  yellow = "fbca04" #fbca04
  red    = "b60205" #b60205

  default_labels_settings = {
    "depName=ghcr.io/renovatebot/renovate" = {
      color = local.green
    }
    "depName=hashicorp/setup-terraform" = {
      color = local.green
    }
    "depName=hashicorp/terraform" = {
      color = local.green
    }
    "depName=opentofu/opentofu" = {
      color = local.green
    }
    "depName=opentofu/setup-opentofu" = {
      color = local.green
    }
    "depName=renovate" = {
      color = local.green
    }
    "depName=renovatebot/github-action" = {
      color = local.green
    }
    "manager=github-actions" = {
      color = local.green
    }
    "manager=regex" = {
      color = local.green
    }
    "packageName=ghcr.io/renovatebot/renovate" = {
      color = local.green
    }
    "packageName=hashicorp/setup-terraform" = {
      color = local.green
    }
    "packageName=hashicorp/terraform" = {
      color = local.green
    }
    "packageName=opentofu/opentofu" = {
      color = local.green
    }
    "packageName=opentofu/setup-opentofu" = {
      color = local.green
    }
    "packageName=renovatebot/github-action" = {
      color = local.green
    }
    dependencies = {
      color = local.yellow
    }
    major = {
      color = local.red
    }
    minor = {
      color = local.yellow
    }
    patch = {
      color = local.green
    }
  }

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
  active_labelsrepos_settings = { for i in flatten([for k, v in local.active_repos_settings : [
    for k2, v2 in local.default_labels_settings : {
      repository = "${k}"
      label      = "${k2}"
      color      = v2.color
    }
    ]
  ]) : "${i.repository}-${i.label}" => i }
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
# output "active_labelsrepos_settings" {
#   value = local.active_labelsrepos_settings
# }
