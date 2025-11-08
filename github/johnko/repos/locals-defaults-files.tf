locals {
  # for resource github_repository_file
  default_files_settings = {
    branch                          = "github-actions-sync"
    overwrite_on_create             = true
    autocreate_branch               = true
    autocreate_branch_source_branch = "main"

  }

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
    if(
      v.sha == null || base64sha256(v.content) != filebase64sha256("../../../${v.file}")
    )
  }

  # for resource github_repository_pull_request
  github_actions_sync_pull_requests = {
    for k in distinct(
      [
        for k, v in local.not_existing_files :
        v.repository
      ]
      ) : k => {
      base_repository = "${k}"
      base_ref        = local.active_files_settings["${k}-.github/renovate.json"].autocreate_branch_source_branch
      head_ref        = local.active_files_settings["${k}-.github/renovate.json"].branch
    }
  }

  # for resource github_branch
  github_actions_sync_branches = {
    for k in distinct(
      [
        for k, v in local.active_files_settings :
        v.repository
      ]
      ) : k => {
      base_repository = "${k}"
      base_ref        = local.active_files_settings["${k}-.github/renovate.json"].autocreate_branch_source_branch
      head_ref        = local.active_files_settings["${k}-.github/renovate.json"].branch
    }
  }
}

# output "active_files_settings" {
#   value = local.active_files_settings
# }
# output "not_existing_files" {
#   value = local.not_existing_files
# }
# output "not_existing_files_repos" {
#   value = local.not_existing_files_repos
# }
