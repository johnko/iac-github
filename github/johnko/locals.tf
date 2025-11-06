locals {
  default_repo_settings = {
    # name = ""
    description  = ""
    homepage_url = ""
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
  }
  repos = {
    deploy = {
      archived     = true
      description  = "Deploying apps, sometimes not the FreeBSD Ports way... WARNING: this might be dumb"
      has_issues   = true
      has_projects = true
    }
    homedir = {
      has_issues = true
      visibility = "public"
    }
    renovate-config = {
      description = "RenovateBot config"
      has_issues  = true
      visibility  = "public"
    }
  }

  all_repos_settings = { for k, v in local.repos : k => merge(local.default_repo_settings, v) }
  active_repos_settings = { for k, v in local.all_repos_settings : k => v
    if v.archived == false
  }
  archived_repos_settings = { for k, v in local.all_repos_settings : k => v
    if v.archived == true
  }
}
