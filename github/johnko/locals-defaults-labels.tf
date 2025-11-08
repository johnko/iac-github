locals {
  green  = "0e8a16" #0e8a16
  yellow = "fbca04" #fbca04
  red    = "b60205" #b60205

  # for resource github_issue_label
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

  # for resource github_issue_label
  active_labelsrepos_settings = { for i in flatten([for k, v in local.active_repos_settings : [
    for k2, v2 in local.default_labels_settings : {
      repository = "${k}"
      label      = "${k2}"
      color      = v2.color
    }
    ]
  ]) : "${i.repository}-${i.label}" => i }
}

# output "active_labelsrepos_settings" {
#   value = local.active_labelsrepos_settings
# }
