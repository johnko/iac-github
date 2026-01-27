#!/usr/bin/env bash
set -euxo pipefail

sudo apt update
sudo apt install --yes shellcheck

go install github.com/mikefarah/yq/v4@v4.50.1
go install mvdan.cc/sh/v3/cmd/shfmt@v3.12.0

cat hashicorp-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install --yes terraform
