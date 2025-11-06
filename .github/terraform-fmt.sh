#!/usr/bin/env bash
set -euxo pipefail

terraform version

terraform fmt -list=true -check -recursive ./

# Fix with
# terraform fmt -recursive ./
