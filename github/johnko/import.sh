#!/usr/bin/env bash
set -euxo pipefail

$IAC_BIN state show 'github_repository.archived["deploy"]' ||
  $IAC_BIN import 'github_repository.archived["deploy"]' deploy

$IAC_BIN state show 'github_repository.active["homedir"]' ||
  $IAC_BIN import 'github_repository.active["homedir"]' homedir

$IAC_BIN state show 'github_repository.active["renovate-config"]' ||
  $IAC_BIN import 'github_repository.active["renovate-config"]' renovate-config
