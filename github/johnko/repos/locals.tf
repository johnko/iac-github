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
    ##########
    bga = merge(
      local.public_repo_with_main_branch,
      {
        description = "simple wrapper to spawn opencode in devcontainer + git worktrees"
        sync_files  = local.files_base
      }
    )
    ##########
    deploy = {
      archived     = true
      description  = "Deploying apps, sometimes not the FreeBSD Ports way... WARNING: this might be dumb"
      has_issues   = true
      has_projects = true
    }
    ##########
    devcontainer-dotfiles = merge(
      local.public_repo_with_main_branch,
      {
        sync_files = local.files_base
      }
    )
    ##########
    dockprom = merge(
      local.forked_public_repo_with_master_branch,
      {
        description  = "Docker hosts and containers monitoring with Prometheus, Grafana, cAdvisor, NodeExporter and AlertManager"
        source_owner = "stefanprodan"
        source_repo  = "dockprom"
        sync_files   = local.files_base
      }
    )
    ##########
    encrypt-message-to-github-user = merge(
      local.public_repo_with_main_branch,
      {
        sync_files = local.files_base
      }
    )
    ##########
    homedir = merge(
      local.public_repo_with_master_branch,
      {
        sync_files = local.files_base
      }
    )
    ##########
    iac-aws = merge(
      local.public_repo_with_main_branch,
      {
        sync_files = merge(
          local.files_base,
          local.files_terraform,
        )
      }
    )
    ##########
    iac-github = merge(
      local.public_repo_with_main_branch,
      {
        sync_files = merge(
          local.files_base,
          local.files_terraform,
        )
      }
    )
    ##########
    lab = merge(
      local.public_repo_with_main_branch,
      {
        sync_files = merge(
          local.files_base,
        )
      }
    )
    ##########
    ollama-code = merge(
      local.forked_public_repo_with_main_branch,
      {
        archived     = true
        description  = "ollama-code is a privacy first coding agent."
        source_owner = "tcsenpai"
        source_repo  = "ollama-code"
      }
    )
    ##########
    renovate-config = merge(
      local.public_repo_with_main_branch,
      {
        sync_files = local.files_base
      }
    )
    ##########
    terraform-aws-eks = merge(
      local.forked_public_repo_with_master_branch,
      {
        homepage_url = "https://registry.terraform.io/modules/terraform-aws-modules/eks/aws"
        source_owner = "terraform-aws-modules"
        source_repo  = "terraform-aws-eks"
        sync_files = merge(
          local.files_base,
          local.files_terraform,
        )
      }
    )
    ##########
    terraform-aws-eks-blueprints = merge(
      local.forked_public_repo_with_main_branch,
      {
        homepage_url = "https://aws-ia.github.io/terraform-aws-eks-blueprints/"
        source_owner = "aws-ia"
        source_repo  = "terraform-aws-eks-blueprints"
        sync_files = merge(
          local.files_base,
          local.files_terraform,
        )
      }
    )
    ##########
  }

  files_terraform = {
    ".github/opentofu-fmt.sh"                = {}
    ".github/opentofu-validate.sh"           = {}
    ".github/terraform-fmt.sh"               = {}
    ".github/terraform-validate.sh"          = {}
    ".github/tf.sh"                          = {}
    ".github/workflows/opentofu-checks.yml"  = {}
    ".github/workflows/terraform-checks.yml" = {}
  }

  files_base = {
    ".github/CODEOWNERS"                    = {}
    ".github/git-has-uncommited-changes.sh" = {}
    ".github/helm-dep.sh"                   = {}
    ".github/pre-commit.sh"                 = {}
    ".github/renovate.json"                 = {}
    ".github/setup-git-pre-commit-hooks.sh" = {}
    ".github/shellcheck.sh"                 = {}
    ".github/shfmt.sh"                      = {}
    ".github/workflows/renovate-config.yml" = {}
    ".github/workflows/renovate.yml"        = {}
    ".github/workflows/shell-checks.yml"    = {}
    ".github/workflows/yaml-checks.yml"     = {}
    ".github/yq-pretty.sh"                  = {}
  }
}
