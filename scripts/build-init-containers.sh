#!/usr/bin/env bash
set -euo pipefail

declare -r SCRIPT_DIR=$(cd $(dirname $0) && pwd)
declare -r ROOT_DIR=$(dirname ${SCRIPT_DIR})
declare -r INIT_CONTAINER_DIR=${ROOT_DIR}/init-containers

# FIXME: Supposedly this should be able to point at "broad-dsp-gcr-public"
declare -r INIT_CONTAINER_PREFIX=us.gcr.io/broad-dsp-monster-dev

function build_and_push () {
    local -r service_dir=$1 version=$2
    local -r service_name=$(basename ${service_dir})
    local -r service_tag="${INIT_CONTAINER_PREFIX}/${service_name}-config:${version}"

    docker build -t ${service_tag} ${service_dir}
    docker push ${service_tag}
}

function main () {
    trap "cd $(pwd)" EXIT
    cd ${ROOT_DIR}

    # Init containers should use first 7 chars of git hash for their tag.
    # https://github.com/broadinstitute/dsp-k8s-deploy/blob/master/adding-a-service.md#building-and-pushing-init-container-images
    local -r version=$(git rev-parse HEAD | cut -c 1-7)

    local -ra service_dirs=($(find ${INIT_CONTAINER_DIR} -depth 1 -type d))

    for service_dir in ${service_dirs[@]}; do
        build_and_push ${service_dir} ${version}
    done
}

main
