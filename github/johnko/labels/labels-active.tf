resource "github_issue_label" "active" {
  for_each = local.active_labelsrepos_settings

  repository = each.value.repository
  name       = each.value.label
  color      = each.value.color
}
