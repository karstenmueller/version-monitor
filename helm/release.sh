#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

script_dir=$(
    cd "$(dirname "$0")"
    pwd -P
)
deploy_dir="$script_dir/../.deploy"

os_name=$(uname | tr '[:upper:]' '[:lower:]')
curl -sSL https://github.com/helm/chart-releaser/releases/download/v0.2.3/chart-releaser_0.2.3_"$os_name"_amd64.tar.gz |
    tar -C "$deploy_dir" -xzf -

helm package "$script_dir" --destination "$deploy_dir"

# helm repo index docs/ --url https://github.io/fielmann-ag/version-monitor/docs

export CR_OWNER=karstenmueller
export CR_CHARTS_REPO=https://github.com/karstenmueller/version-monitor/
export CR_GIT_REPO=version-monitor
export CR_PACKAGE_PATH="$deploy_dir"
export CR_TOKEN="$GH_TOKEN" # from environment

"$deploy_dir"/cr upload
