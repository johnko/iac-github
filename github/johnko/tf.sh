#!/usr/bin/env bash
set -eo pipefail

ACTION="$1"
if [[ -z $ACTION ]]; then
  echo "ERROR: missing 'ACTION' as 1st argument"
  exit 1
fi
# transform the action arg into uppercase
SAFE_ACTION=$(echo "$ACTION" | tr 'a-z' 'A-Z')
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
terraform validate
if [[ "APPLY" == $SAFE_ACTION || "AUTO" == $SAFE_ACTION || "PLAN" == $SAFE_ACTION ]]; then
  terraform init
fi
if [[ "APPLY" == $SAFE_ACTION || "AUTO" == $SAFE_ACTION || "PLAN" == $SAFE_ACTION ]]; then
  terraform plan -detailed-exitcode -input=false -parallelism=5
  if [[ "PLAN" == $SAFE_ACTION ]]; then
    exit 0
  fi
fi
if [[ "APPLY" == $SAFE_ACTION || "AUTO" == $SAFE_ACTION ]]; then
  terraform apply
fi
