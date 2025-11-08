locals {
  # for resource github_repository_file
  default_files_settings = {
    branch                          = "github-actions-init"
    commit_author                   = "johnko"
    commit_email                    = "279736+johnko@users.noreply.github.com"
    overwrite_on_create             = true
    autocreate_branch               = true
    autocreate_branch_source_branch = "main"

  }

  # for resource github_issue_label
  active_files_settings = { for i in flatten([for k, v in local.active_repos_settings : [
    for k2, v2 in local.files : merge(
      local.default_files_settings,
      {
        repository                      = "${k}"
        file                            = "${k2}"
        autocreate_branch_source_branch = v.branch_default
      },
      v2,
    )
    ]
  ]) : "${i.repository}-${i.file}" => i }
}

output "active_files_settings" {
  value = local.active_files_settings
}
