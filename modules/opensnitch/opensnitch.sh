#!/usr/bin/env bash

# Module for downloading and installing the latest Opensnitch release

set -euo pipefail

INSTALL=$(echo "$1" | jq -r 'try .["install"]')

echo "$INSTALL"

#Curl the proper urls





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
