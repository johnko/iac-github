locals {
  repos = {
    deploy = {
      archived     = true
      description  = "Deploying apps, sometimes not the FreeBSD Ports way... WARNING: this might be dumb"
      has_issues   = true
      has_projects = true
    }
    homedir = {
      actions = {
        enabled = true
      }
      branch_default = "master"
      has_issues     = true
      visibility     = "public"
    }
    iac-github = {
      actions = {
        enabled = true
      }
      has_issues = true
      visibility = "public"
    }
    lab = {
      actions = {
        enabled = true
      }
      has_issues = true
      visibility = "public"
    }
    renovate-config = {
      actions = {
        enabled = true
      }
      description = "RenovateBot config"
      has_issues  = true
      visibility  = "public"
    }
  }
}
