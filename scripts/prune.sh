#!/usr/bin/env sh

## THIS IS TO CLEAN THE RELEASE RELATED TO YOUR CURRENT BRANCH IN GIT.
## *****IT CAN BE VERY DESTRUCTIVE*****
## Be sure you're on the right git branch. 

CWD=$(dirname "$0")
. "${CWD}/vars.sh"
. "${CWD}/functions.sh"
getLocalSecrets
getEnv

helm uninstall "${ENV}" -n "${K8S_NAMESPACE}" --post-renderer ${KUSTOMIZE_FILE}
if test "${1}" = "--heavy" ; then
  kubectl delete pvc --selector=app.kubernetes.io/instance="${ENV}"
  kubectl delete ns "${K8S_NAMESPACE}"
fi

echo "${GREEN} INFO: Environment pruned - ${ENV} ${NC}"