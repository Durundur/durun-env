#!/bin/bash

set -e

./config.sh --url https://github.com/${GITHUB_OWNER}/${GITHUB_REPOSITORY} \
    --token ${GITHUB_TOKEN} \
    --name "deploy-runner" \
    --unattended \
    --replace

./run.sh