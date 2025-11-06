#!/usr/bin/env bash
set -euxo pipefail

# when running in CI and opentofu doesn't exist, install it
if [[ -n $CI ]]; then
  if ! type tofu &>/dev/null; then
    SUDO=''
    if type sudo &>/dev/null; then
      SUDO=sudo
    fi
    if type brew &>/dev/null; then
      brew install opentofu
    elif type snap &>/dev/null; then
      INSTALL_COMMAND="snap install --classic opentofu"
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    fi
  fi
fi
set -u

tofu version

tofu fmt -list=true -check -recursive ./

# Fix with
# tofu fmt -recursive ./
