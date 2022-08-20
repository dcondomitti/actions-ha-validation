#!/usr/bin/env bash
set -euo pipefail

stat ${GITHUB_WORKSPACE}/custom_components || mkdir -p ${GITHUB_WORKSPACE}/custom_components

IFS='/' read -r -a url <<< "$INPUT_REPOSITORY"
default_name=${url[4]}
INPUT_NAME=${INPUT_NAME:-$default_name}

mkdir -p /tmp/${INPUT_NAME}
pushd /tmp/${INPUT_NAME}
git init .
git remote add origin ${INPUT_REPOSITORY}
git config core.sparseCheckout true
echo "custom_components/${INPUT_NAME}" > .git/info/sparse-checkout
git pull origin ${INPUT_BRANCH}
ln -s /tmp/${INPUT_NAME}/custom_components/${INPUT_NAME} ${GITHUB_WORKSPACE}/custom_components/${INPUT_NAME}
