locals {
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
}
