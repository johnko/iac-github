#!/usr/bin/env bash
set -euxo pipefail

FILE_CHANGED_COUNT=$( git status -s | wc -l | tr -d ' ' )
if [[ $FILE_CHANGED_COUNT -gt 0 ]]; then
exit 1
fi
