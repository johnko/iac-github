#!/usr/bin/env bash
set -euxo pipefail

shfmt --diff --simplify --indent 2 --case-indent ./

# Fix with
# shfmt --write --simplify --indent 2 --case-indent ./
