#!/usr/bin/env bash
set -euxo pipefail

$IAC_BIN state show 'github_repository.archived["deploy"]' ||
  $IAC_BIN import 'github_repository.archived["deploy"]' deploy

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
