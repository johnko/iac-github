#!/usr/bin/env bash
set -euxo pipefail

ARCHIVED_REPOS="
deploy
"

for i in $ARCHIVED_REPOS; do
  $IAC_BIN state show "github_repository.archived[\"$i\"]" ||
    $IAC_BIN import "github_repository.archived[\"$i\"]" "$i"
done

ACTIVE_REPOS="
homedir
iac-github
lab
renovate-config
"

for i in $ACTIVE_REPOS; do
  $IAC_BIN state show "github_repository.active[\"$i\"]" ||
    $IAC_BIN import "github_repository.active[\"$i\"]" "$i"
done

for i in $ACTIVE_REPOS; do
  $IAC_BIN state show "github_actions_repository_permissions.active[\"$i\"]" ||
    $IAC_BIN import "github_actions_repository_permissions.active[\"$i\"]" "$i"
done

LABELS="
depName=ghcr.io/renovatebot/renovate
depName=renovate
depName=renovatebot/github-action
manager=github-actions
packageName=ghcr.io/renovatebot/renovate
packageName=renovatebot/github-action
dependencies
major
minor
patch
"

for i in $ACTIVE_REPOS; do
  for l in $LABELS; do
    $IAC_BIN state show "github_issue_label.active[\"$i-$l\"]" ||
      $IAC_BIN import "github_issue_label.active[\"$i-$l\"]" "$i:$l" || true
  done
done
