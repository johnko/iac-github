#!/usr/bin/env bash
set -euxo pipefail

for i in $(terraform state list | grep -E 'github_repository_file.to_create|github_repository_pull_request.to_create'); do
  terraform state rm "$i"
done
