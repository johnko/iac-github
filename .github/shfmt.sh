#!/usr/bin/env bash
set -exo pipefail

# when running in CI and shfmt doesn't exist, install it
if [[ -n "$CI" ]]; then
  if ! type shfmt &>/dev/null ; then
    if uname -a | grep -i -q 'notfoundnotfoundnotfoundnotfoundnotfound' ; then
      apt install --yes shfmt
    else
      go install mvdan.cc/sh/v3/cmd/shfmt@3.11.0
    fi
  fi
fi
set -u

shfmt --diff --simplify --indent 2 --case-indent ./

# Fix with
# shfmt --write --simplify --indent 2 --case-indent ./
