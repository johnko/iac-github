#!/usr/bin/env bash
set -euxo pipefail

# shellcheck disable=SC1091
source _import-active-repos.sh

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
