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
  files = {
    ".github/git-has-uncommited-changes.sh"  = {}
    ".github/opentofu-fmt.sh"                = {}
    ".github/opentofu-validate.sh"           = {}
    ".github/pre-commit.sh"                  = {}
    ".github/renovate.json"                  = {}
    ".github/shellcheck.sh"                  = {}
    ".github/shfmt.sh"                       = {}
    ".github/terraform-fmt.sh"               = {}
    ".github/terraform-validate.sh"          = {}
    ".github/workflows/opentofu-checks.yml"  = {}
    ".github/workflows/renovate.yml"         = {}
    ".github/workflows/shell-checks.yml"     = {}
    ".github/workflows/terraform-checks.yml" = {}
    ".github/workflows/yaml-checks.yml"      = {}
    ".github/yq-pretty.sh"                   = {}
  }
}
