#!/usr/bin/env bash
set -euxo pipefail

# shellcheck disable=SC1091
source import-active-repos.sh

LABELS="
dependencies
depName=ghcr.io/renovatebot/renovate
depName=hashicorp/setup-terraform
depName=hashicorp/terraform
depName=opentofu/opentofu
depName=opentofu/setup-opentofu
depName=renovate
depName=renovatebot/github-action
major
manager=github-actions
manager=regex
minor
packageName=ghcr.io/renovatebot/renovate
packageName=hashicorp/setup-terraform
packageName=hashicorp/terraform
packageName=opentofu/opentofu
packageName=opentofu/setup-opentofu
packageName=renovatebot/github-action
patch
"

for i in $ACTIVE_REPOS; do
  for l in $LABELS; do
    $IAC_BIN state show "github_issue_label.active[\"$i-$l\"]" &&
      $IAC_BIN state rm "github_issue_label.active[\"$i-$l\"]" || true
  done
done

ARCHIVED_REPOS="
deploy
"

for i in $ARCHIVED_REPOS; do
  $IAC_BIN state show "github_repository.archived[\"$i\"]" ||
    $IAC_BIN import "github_repository.archived[\"$i\"]" "$i"
done

for i in $ACTIVE_REPOS; do
  $IAC_BIN state show "github_repository.active[\"$i\"]" ||
    $IAC_BIN import "github_repository.active[\"$i\"]" "$i"
done

for i in $ACTIVE_REPOS; do
  $IAC_BIN state show "github_actions_repository_permissions.active[\"$i\"]" ||
    $IAC_BIN import "github_actions_repository_permissions.active[\"$i\"]" "$i"
done

for i in $ACTIVE_REPOS; do
  $IAC_BIN state show "github_branch_default.active[\"$i\"]" ||
    $IAC_BIN import "github_branch_default.active[\"$i\"]" "$i"
done

for i in $ACTIVE_REPOS; do
  $IAC_BIN state show "github_branch.to_create[\"$i\"]" ||
    $IAC_BIN import "github_branch.to_create[\"$i\"]" "$i:github-actions-sync" || true
done
