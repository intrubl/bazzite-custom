#!/usr/bin/env bash

# Module for downloading and installing the latest Opensnitch release

set -euo pipefail

INSTALL=$(echo "$1" | jq -r 'try .["apples"]')

echo "$INSTALL"

if [[ "$INSTALL" == "true" ]]; then

    declare -A DL_URLS
    DL_URLS["OPENSNITCH_RPM"]=$(curl -s "https://api.github.com/repos/evilsocket/opensnitch/releases/latest" | jq -r '.assets[] | select(.name | test("opensnitch-\\d.*\\.x86_64.rpm")) | .browser_download_url')
    DL_URLS["OPENSNITCH_UI_RPM"]=$(curl -s "https://api.github.com/repos/evilsocket/opensnitch/releases/latest" | jq -r '.assets[] | select(.name | test("opensnitch-ui-\\d.*\\.noarch.rpm")) | .browser_download_url')

    # Probably a better way to format this
    for url in "${!DL_URLS[@]}"; do
        if [[ ! ${DL_URLS[$url]} =~ ^https?://.*\.rpm$ ]]; then
            echo "$url is incorrect or improperly formatted! Aborting..."
            exit 1
        fi
    done

    echo "Installing opensnitch packages:"
    rpm-ostree install "${DL_URLS[@]}"
fi

#
# # read a single variable from the configuration
# # `try` makes the command output 'null' if the key is not found, otherwise it will error out and the build will fail
# # the `.["var"]` syntax is optional and could be replaced with the less safe and more error-prone `.var` syntax
# VAR=$(echo "$1" | jq -r 'try .["var"]')
# echo "$VAR"
#
# # read an array from the configuration
# get_json_array ARRAY 'try .["array"][]' "$1"
# # loop over the array
# for THING in "${ARRAY[@]}"; do
#     echo "$THING"
# done
