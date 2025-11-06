#!/usr/bin/env bash
set -eo pipefail

if [[ -z $IAC_BIN ]]; then
  export IAC_BIN=terraform
fi

ACTION="$1"
if [[ -z $ACTION ]]; then
  echo "ERROR: missing 'ACTION' as 1st argument"
  exit 1
fi
# transform the action arg into uppercase
SAFE_ACTION=$(echo "$ACTION" | tr '[:lower:]' '[:upper:]')
case $SAFE_ACTION in
  APPLY | AUTO | FMT | INIT | PLAN | VALIDATE)
    echo "ACTION=$ACTION"
    ;;
  *)
    set +x
    echo "ERROR: invalid 'ACTION', received '$ACTION'"
    exit 1
    ;;
esac
echo "SAFE_ACTION=$SAFE_ACTION"
set -ux
$IAC_BIN fmt
set +x
if [[ "APPLY" == "$SAFE_ACTION" || "AUTO" == "$SAFE_ACTION" || "PLAN" == "$SAFE_ACTION" || "VALIDATE" == "$SAFE_ACTION" ]]; then
  set -x
  $IAC_BIN init
fi
$IAC_BIN validate
set +x
if [[ "APPLY" == "$SAFE_ACTION" || "AUTO" == "$SAFE_ACTION" || "PLAN" == "$SAFE_ACTION" ]]; then
  if [[ -e import.sh ]]; then
    bash -ex import.sh
  fi
  set -x
  $IAC_BIN plan -detailed-exitcode -input=false -parallelism=5
  set +x
  if [[ "PLAN" == "$SAFE_ACTION" ]]; then
    set -x
    exit 0
  fi
fi
set +x
if [[ "APPLY" == "$SAFE_ACTION" || "AUTO" == "$SAFE_ACTION" ]]; then
  set -x
  $IAC_BIN apply
fi
