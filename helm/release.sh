#!/usr/bin/env bash

set -x
set -e
set -o nounset
set -o pipefail

DEST="../.deploy"

helm package . --destination "$DEST"

# helm repo index docs/ --url https://github.io/fielmann-ag/version-monitor/docs

export CR_OWNER=karstenmueller
export CR_CHARTS_REPO=https://github.com/karstenmueller/version-monitor/
export CR_GIT_REPO=version-monitor
export CR_PACKAGE_PATH="$DEST"
# export CR_TOKEN="123456789"
# export CR_GIT_BASE_URL="https://api.github.com/"
# export CR_GIT_UPLOAD_URL="https://uploads.github.com/"

cr index
