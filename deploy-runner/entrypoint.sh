#!/bin/bash

set -e

GITHUB_TOKEN=$(curl -sL \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${DEPLOY_RUNNER_TOKEN}" \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPOSITORY}/actions/runners/registration-token \
  | jq -r '.token')

./config.sh --url https://github.com/${GITHUB_OWNER}/${GITHUB_REPOSITORY} \
    --token ${GITHUB_TOKEN} \
    --name "deploy-runner" \
    --unattended \
    --replace

./run.sh