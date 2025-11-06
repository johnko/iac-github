#!/usr/bin/env bash
set -eo pipefail

if [[ -z $IAC_BIN ]]; then
  export IAC_BIN=terraform
fi

WORKSPACE="$1"
if [[ -z $WORKSPACE ]]; then
  echo "ERROR: missing 'WORKSPACE' as 1st argument"
  exit 1
fi
if [[ ! -d $WORKSPACE ]]; then
  echo "ERROR: invalid 'WORKSPACE', received '$WORKSPACE'"
  exit 1
fi
pushd "$WORKSPACE"

ACTION="$2"
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
  set +e
  $IAC_BIN plan -detailed-exitcode -input=false -parallelism=5
  TF_PLAN_EXIT_CODE=$?
  set -e
  set +x
  if [[ "PLAN" == "$SAFE_ACTION" ]]; then
    set -x
    exit $TF_PLAN_EXIT_CODE
  fi
fi
set +x
if [[ "APPLY" == "$SAFE_ACTION" || "AUTO" == "$SAFE_ACTION" ]]; then
  AUTO_APPROVE_ARG=""
  if [[ "AUTO" == "$SAFE_ACTION" ]]; then
    AUTO_APPROVE_ARG="-auto-approve"
  fi
  set -x
  set +e
  $IAC_BIN apply $AUTO_APPROVE_ARG -input=false -parallelism=5
  TF_APPLY_EXIT_CODE=$?
  exit $TF_APPLY_EXIT_CODE
fi
set -e
popd
