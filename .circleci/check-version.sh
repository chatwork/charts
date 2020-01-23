#!/usr/bin/env bash

set -u

FROM=remotes/origin/master
PWD="$(pwd)"
NAME="$(basename ${PWD})"

# If there is no diff in the current directory, then exit 0
DIFF="$(git --no-pager diff --name-only "${FROM}" HEAD .)"
if [ -z "${DIFF}" ]; then
  echo "[${NAME}] none diff"
  exit 0
fi

# Check whether the version in Chart.yaml was updated or not.
DIFF_CHART_YAML="$(git --no-pager diff "${FROM}" HEAD Chart.yaml | grep 'version: ')"

echo "========================================"
echo " [${NAME}] diff version"
echo "${DIFF_CHART_YAML}"
echo "========================================"

if [ -z "${DIFF_CHART_YAML}" ]; then
  echo "You must bump the Chart version!"
  exit 1
fi

# If the updated version was lower than the base branch, it causes an error.
VERSIONS=$(echo "${DIFF_CHART_YAML}"| sed -e 's/[+-]version: //g' -e "s/[\"\' ]//g")
SORTED=$(echo "${VERSIONS}" | sort --version-sort | uniq)
DIFF_VERSION="$(diff -u <(echo "${VERSIONS}") <(echo "${SORTED}"))"

if [ -n "${DIFF_VERSION}" ]; then
  echo "You must bump Chart version!"
  exit 1
fi
