#!/usr/bin/env bash
set -euxo pipefail

# shellcheck disable=SC1091
source _import-active-repos.sh

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
    $IAC_BIN state show "github_issue_label.active[\"$i-$l\"]" ||
      $IAC_BIN import "github_issue_label.active[\"$i-$l\"]" "$i:$l" || true
  done
done
