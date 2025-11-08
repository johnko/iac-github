locals {
  # for resource github_repository_file
  default_files_settings = {
    branch                          = "github-actions-init"
    overwrite_on_create             = true
    autocreate_branch               = true
    autocreate_branch_source_branch = "main"

  }

  # for resource github_issue_label
  active_files_settings = {
    for i in flatten(
      [
        for k, v in local.active_repos_settings :
        [
          for k2, v2 in local.files :
          merge(
            local.default_files_settings,
            {
              repository                      = "${k}"
              file                            = "${k2}"
              autocreate_branch_source_branch = v.branch_default
            },
            v2,
          )
        ]
      ]
    ) :
    "${i.repository}-${i.file}" => i
  }

  not_existing_files = {
    for k, v in data.github_repository_file.exists :
    k => local.active_files_settings[k]
    if v.sha == null
  }
}

# output "active_files_settings" {
#   value = local.active_files_settings
# }
# output "not_existing_files" {
#   value = local.not_existing_files
# }
