locals {
  actions_enabled = { enabled = true }

  public_repo_with_main_branch = {
    actions    = local.actions_enabled
    has_issues = true
    visibility = "public"
  }

  public_repo_with_master_branch = merge(
    local.public_repo_with_main_branch,
    { branch_default = "master" }
  )

  forked_public_repo_with_main_branch = merge(
    local.public_repo_with_main_branch,
    { allow_merge_commit = true }
  )

  forked_public_repo_with_master_branch = merge(
    local.public_repo_with_main_branch,
    {
      allow_merge_commit = true
      branch_default     = "master"
    }
  )

  repos = {
    deploy = {
      archived     = true
      description  = "Deploying apps, sometimes not the FreeBSD Ports way... WARNING: this might be dumb"
      has_issues   = true
      has_projects = true
    }
    encrypt-message-to-github-user = local.public_repo_with_main_branch
    homedir                        = local.public_repo_with_master_branch
    iac-github                     = local.public_repo_with_main_branch
    lab                            = local.public_repo_with_main_branch
    renovate-config                = local.public_repo_with_main_branch
    terraform-aws-eks = merge(
      local.forked_public_repo_with_master_branch,
      { homepage_url = "https://registry.terraform.io/modules/terraform-aws-modules/eks/aws" }
    )
    terraform-aws-eks-blueprints = merge(
      local.forked_public_repo_with_main_branch,
      { homepage_url = "https://aws-ia.github.io/terraform-aws-eks-blueprints/" }
    )
  }
  files = {
    ".github/git-has-uncommited-changes.sh"  = {}
    ".github/helm-dep.sh"                    = {}
    ".github/opentofu-fmt.sh"                = {}
    ".github/opentofu-validate.sh"           = {}
    ".github/pre-commit.sh"                  = {}
    ".github/renovate.json"                  = {}
    ".github/shellcheck.sh"                  = {}
    ".github/CODEOWNERS"                     = {}
    ".github/shfmt.sh"                       = {}
    ".github/terraform-fmt.sh"               = {}
    ".github/terraform-validate.sh"          = {}
    ".github/tf.sh"                          = {}
    ".github/workflows/opentofu-checks.yml"  = {}
    ".github/workflows/renovate-config.yml"  = {}
    ".github/workflows/renovate.yml"         = {}
    ".github/workflows/shell-checks.yml"     = {}
    ".github/workflows/terraform-checks.yml" = {}
    ".github/workflows/yaml-checks.yml"      = {}
    ".github/yq-pretty.sh"                   = {}
  }
}
