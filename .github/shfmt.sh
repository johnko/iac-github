#!/usr/bin/env bash
set -exo pipefail

# when running in CI and shfmt doesn't exist, install it
if [[ -n $CI ]]; then
  if ! type shfmt &>/dev/null; then
    if type brew &>/dev/null; then
      brew install shfmt
    elif type go &>/dev/null; then
      if [[ ! -d "$HOME/bin" ]]; then
        mkdir -p "$HOME/bin"
      fi
      export GOBIN="$HOME/bin"
      export PATH="$GOBIN:$PATH"
      go install mvdan.cc/sh/v3/cmd/shfmt@v3.11.0
      ls -l $GOBIN/shfmt
    elif type apt &>/dev/null; then
      SUDO=''
      if type sudo &>/dev/null; then
        SUDO=sudo
      fi
      apt install --yes shfmt || $SUDO apt install --yes shfmt
    fi
  fi
fi
set -u

shfmt --version

shfmt --diff --simplify --indent 2 --case-indent ./

# Fix with
# shfmt --write --simplify --indent 2 --case-indent ./
