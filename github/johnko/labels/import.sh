#!/usr/bin/env bash
set -euxo pipefail

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
