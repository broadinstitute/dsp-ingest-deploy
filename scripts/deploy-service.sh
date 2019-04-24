#!/usr/bin/env bash
set -euo pipefail

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)
declare -r ROOT_DIR=$(dirname ${SCRIPT_DIR})
declare -r PROFILES_DIR=${ROOT_DIR}/profiles

function service_dir () {
    local -r service_name=$1

    echo ${PROFILES_DIR}/${service_name}/k8s/${service_name}
}

function apply_config () {
    kubectl -n dev apply -f $1

}

function deploy () {
    local -r config_dir=$1

    apply_config ${config_dir}/role.yaml
    apply_config ${config_dir}/service-account.yaml
    apply_config ${config_dir}/role-binding.yaml
    apply_config ${config_dir}/deployment.yaml
    apply_config ${config_dir}/service.yaml
}

function main () {
    if [ $# -ne 1 ]; then
        >&2 echo "Please provide a service name to deploy"
        exit 1
    fi

    deploy $(service_dir $1)
}

main ${@}
