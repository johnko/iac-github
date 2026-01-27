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
    {
      allow_merge_commit = true
      fork               = true
    }
  )

  forked_public_repo_with_master_branch = merge(
    local.public_repo_with_main_branch,
    {
      allow_merge_commit = true
      branch_default     = "master"
      fork               = true
    }
  )

  repos = {
    deploy = {
      archived     = true
      description  = "Deploying apps, sometimes not the FreeBSD Ports way... WARNING: this might be dumb"
      has_issues   = true
      has_projects = true
    }
    dockprom = merge(
      local.forked_public_repo_with_master_branch,
      {
        description  = "Docker hosts and containers monitoring with Prometheus, Grafana, cAdvisor, NodeExporter and AlertManager"
        source_owner = "stefanprodan"
        source_repo  = "dockprom"
      }
    )
    encrypt-message-to-github-user = local.public_repo_with_main_branch
    homedir                        = local.public_repo_with_master_branch
    iac-github                     = local.public_repo_with_main_branch
    lab                            = local.public_repo_with_main_branch
    ollama-code = merge(
      local.forked_public_repo_with_main_branch,
      {
        archived     = true
        description  = "ollama-code is a privacy first coding agent."
        source_owner = "tcsenpai"
        source_repo  = "ollama-code"
      }
    )
    renovate-config = local.public_repo_with_main_branch
    terraform-aws-eks = merge(
      local.forked_public_repo_with_master_branch,
      {
        homepage_url = "https://registry.terraform.io/modules/terraform-aws-modules/eks/aws"
        source_owner = "terraform-aws-modules"
        source_repo  = "terraform-aws-eks"
      }
    )
    terraform-aws-eks-blueprints = merge(
      local.forked_public_repo_with_main_branch,
      {
        homepage_url = "https://aws-ia.github.io/terraform-aws-eks-blueprints/"
        source_owner = "aws-ia"
        source_repo  = "terraform-aws-eks-blueprints"
      }
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
    ".github/setup-git-pre-commit-hooks.sh"  = {}
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
