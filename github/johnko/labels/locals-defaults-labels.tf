locals {
  green  = "0e8a16" #0e8a16
  yellow = "fbca04" #fbca04
  red    = "b60205" #b60205

  # for resource github_issue_label
  default_labels = {
    "dependencies" = {
      color = local.yellow
    }
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
    "major" = {
      color = local.red
    }
    "manager=github-actions" = {
      color = local.green
    }
    "manager=regex" = {
      color = local.green
    }
    "minor" = {
      color = local.yellow
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
    "patch" = {
      color = local.green
    }
  }

  active_labelsrepos_settings = {
    for i in flatten(
      [
        for k, v in local.active_repos_settings :
        [
          for k2, v2 in local.default_labels :
          {
            repository = "${k}"
            label      = "${k2}"
            color      = v2.color
          }
        ]
      ]
    ) :
    "${i.repository}-${i.label}" => i
  }
}

# output "active_labelsrepos_settings" {
#   value = local.active_labelsrepos_settings
# }
