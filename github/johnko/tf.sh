#!/usr/bin/env bash
set -eo pipefail

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
terraform fmt
set +x
if [[ "APPLY" == "$SAFE_ACTION" || "AUTO" == "$SAFE_ACTION" || "PLAN" == "$SAFE_ACTION" || "VALIDATE" == "$SAFE_ACTION" ]]; then
  set -x
  terraform init
fi
terraform validate
set +x
if [[ "APPLY" == "$SAFE_ACTION" || "AUTO" == "$SAFE_ACTION" || "PLAN" == "$SAFE_ACTION" ]]; then
  set -x
  terraform plan -detailed-exitcode -input=false -parallelism=5
  set +x
  if [[ "PLAN" == "$SAFE_ACTION" ]]; then
    set -x
    exit 0
  fi
fi
set +x
if [[ "APPLY" == "$SAFE_ACTION" || "AUTO" == "$SAFE_ACTION" ]]; then
  set -x
  terraform apply
fi
