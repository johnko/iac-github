#!/usr/bin/env bash
set -euxo pipefail

find . -type f -name '*.yaml' -o -name '*.yml' -exec  yq --exit-status --inplace --no-colors --prettyPrint 'sort_keys(..)' {} \;

          bash -ex ./.github/git-has-uncommited-changes.sh
