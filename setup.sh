#!/usr/bin/env bash
set -euxo pipefail

SCRIPT_DIR=$(dirname $0)
pushd "$SCRIPT_DIR"

if [[ -e .github/pre-commit.sh ]]; then
  install -m 700 .github/pre-commit.sh .git/hooks/pre-commit
fi
