#!/usr/bin/env bash
set -euxo pipefail

# when running in CI and terraform doesn't exist, install it
if [[ -n $CI ]]; then
  if ! type terraform &>/dev/null; then
    if type brew &>/dev/null; then
      brew tap hashicorp/tap
      brew install hashicorp/tap/terraform
    elif type apt &>/dev/null; then
      SUDO=''
      if type sudo &>/dev/null; then
        SUDO=sudo
      fi
      wget -O - https://apt.releases.hashicorp.com/gpg | $SUDO gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | $SUDO tee /etc/apt/sources.list.d/hashicorp.list
      $SUDO apt update
      INSTALL_COMMAND="apt install --yes terraform"
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    fi
  fi
fi
set -u

terraform version

terraform fmt -list=true -check -recursive ./

# Fix with
# terraform fmt -recursive ./
