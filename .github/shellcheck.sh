#!/usr/bin/env bash
set -exo pipefail

# when running in CI and shellcheck doesn't exist, install it
if [[ "true" == "$CI" ]]; then
  if ! type shellcheck &>/dev/null; then
    SUDO=''
    if type sudo &>/dev/null; then
      SUDO=sudo
    fi
    if type brew &>/dev/null; then
      brew install shellcheck
    elif type snap &>/dev/null; then
      INSTALL_COMMAND="snap install shellcheck"
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    elif type apt &>/dev/null; then
      SUDO=''
      if type sudo &>/dev/null; then
        SUDO=sudo
      fi
      INSTALL_COMMAND="apt install --yes shellcheck"
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    fi
  fi
fi
set -u

shellcheck --version

set +e

TEMP_LOG=$(mktemp)
find . -type f -name '*.sh' -exec shellcheck --check-sourced --external-sources {} \; | tee $TEMP_LOG

PROBLEM_COUNT=$(cat $TEMP_LOG | wc -l | tr -d ' ')
rm $TEMP_LOG
if [[ $PROBLEM_COUNT -gt 0 ]]; then
  exit 1
fi
